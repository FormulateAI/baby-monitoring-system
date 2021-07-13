import cv2
import argparse
import orien_lines
import datetime
from imutils.video import VideoStream
from utils import detector_utils as detector_utils
import pandas as pd
from datetime import date
import xlrd
from xlwt import Workbook
from xlutils.copy import copy
import numpy as np
from truck_lpr_demo import detect_license_plate

lst1 = []
lst2 = []
ap = argparse.ArgumentParser()
ap.add_argument('-d', '--display', dest='display', type=int,
                default=1, help='Display the detected images using OpenCV. This reduces FPS')
args = vars(ap.parse_args())

detection_graph, sess = detector_utils.load_inference_graph()



if __name__ == '__main__':
    # Detection confidence threshold to draw bounding box
    score_thresh = 0.80

    # vs = cv2.VideoCapture('rtsp://192.168.1.64')
    #vs = VideoStream(0).start()
    # Oriendtation of machine
    dir=['lr','rl','bt','tb']
    for i in dir:
        Orientation = i
    # input("Enter the orientation of hand progression ~ lr,rl,bt,tb :")

    # For Machine
    # Line_Perc1=float(input("Enter the percent of screen the line of machine :"))
    Line_Perc1 = float(15)

    # For Safety
    # Line_Perc2=float(input("Enter the percent of screen for the line of safety :"))
    Line_Perc2 = float(30)

    # max number of hands we want to detect/track
    num_hands_detect = 2

    # Used to calculate fps
    start_time = datetime.datetime.now()
    num_frames = 0

    im_height, im_width = (None, None)
    cv2.namedWindow('Detection', cv2.WINDOW_NORMAL)


    def count_no_of_times(lst):
        x = y = cnt = 0
        for i in lst:
            x = y
            y = i
            if x == 0 and y == 1:
                cnt = cnt + 1
        return cnt


    try:
        while True:
            mypath = "D:\\BMS_final\\test_images\\baby_sleeping.jpg"
            img = cv2.imread(mypath, 1)


            #frame = vs.read()
            frame = np.array(img)
            # frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)

            if im_height == None:
                im_height, im_width = frame.shape[:2]

            # Convert image to rgb since opencv loads images in bgr, if not accuracy will decrease
            try:
                frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            except:
                print("Error converting to RGB")
            # cv2.line(img=frame, pt1=(0, Line_Position1), pt2=(frame.shape[1], Line_Position1), color=(255, 0, 0), thickness=2, lineType=8, shift=0)

            # cv2.line(img=frame, pt1=(0, Line_Position2), pt2=(frame.shape[1], Line_Position2), color=(255, 0, 0), thickness=2, lineType=8, shift=0)

            # Run image through tensorflow graph
            boxes, scores, classes = detector_utils.detect_objects(
                frame, detection_graph, sess)

            Line_Position2 = orien_lines.drawsafelines(frame, Orientation, Line_Perc1, Line_Perc2)
            # Draw bounding boxeses and text
            for i in range(len(dir)):
                a, b = detector_utils.draw_box_on_image(
                    num_hands_detect, score_thresh, scores, boxes, classes, im_width, im_height, frame, Line_Position2,
                    Orientation)
            lst1.append(a)
            lst2.append(b)
            no_of_time_hand_detected = no_of_time_hand_crossed = 0
            # Calculate Frames per second (FPS)
            num_frames += 1
            elapsed_time = (datetime.datetime.now() -
                            start_time).total_seconds()
            fps = num_frames / elapsed_time

            if args['display']:

                # Display FPS on frame
                detector_utils.draw_text_on_image("FPS : " + str("{0:.2f}".format(fps)), frame)
                cv2.imshow('Detection', cv2.cvtColor(frame, cv2.COLOR_RGB2BGR))
                if cv2.waitKey(25) & 0xFF == ord('q'):
                    cv2.destroyAllWindows()
                    img.stop()
                    break

        no_of_time_baby_detected = count_no_of_times(lst2)
        no_of_time_baby_crossed = count_no_of_times(lst1)


    except KeyboardInterrupt:
        no_of_time_baby_detected = count_no_of_times(lst2)
        no_of_time_baby_crossed = count_no_of_times(lst1)
        today = date.today()
