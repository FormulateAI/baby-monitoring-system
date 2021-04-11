import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  final String title = "Baby Monitoring System";
  final String description =
      "A newborn brings lots of happiness in the family, but with plethora of responsibilities. There are many questions, which creates anxiety to new parents. e.g. Do we need to be near the baby all the time? What if the baby needs someone and there is no one? These questions sometime force mother to quit job to take care of their babies. \n\n Besides babysitting, there is also some regular daily routine, which makes it impossible to carry a new born all the time. Some parents use CCTV cameras to check their babies, but they cannot notify in case of emergency. There are some wearable devices for babies which send signals to alert parents, but parents don’t prefer these because of electromagnetic waves from these devices. \n\n There are various other devices available in the market to monitor baby when parents are not around but they are not affordable to many of the parents. The other problem with these devices are that they detect high pitch sounds, give false alarm sometimes, and disturb kids as well as parents. Some mobile applications are also there but all are based on sound which give alarm only when the baby is crying. \n\n The Idea is to design a mobile-based application, which can detect baby position in the crib/bed .The application will notify the parents when baby needs them, It ‘ll be able to detect whether the baby is sleeping in safe position or in hazardous position, keep a record of baby sleeping pattern. There is no hardware dependency, which make it cheaper and available for all. ";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(height: 25),
        Text(
          title,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w600,
          ),
        ),
        // Icon(
        //   Icons.child_care,
        //   size: 100,
        // ),
        SizedBox(height: size.height * 0.04),
        Text(
          description,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
