import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myhabeeb/LoginPages/loginPage.dart';
import 'package:myhabeeb/LoginPages/registerpage.dart';

class Welcomepage extends StatefulWidget {
  const Welcomepage({super.key});

  @override
  State<Welcomepage> createState() => _WelcomepageState();
}

class _WelcomepageState extends State<Welcomepage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            width: screenWidth,
            height: screenHeight,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: screenHeight * 0.5,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo3.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          
          
                SizedBox(
                  height: screenHeight * 0.05,
                ),
         
                 
                Padding(
                  padding: const EdgeInsets.symmetric( horizontal: 18.0),
                  child: Center(
                    child: Text(
                      ' الحبيب ',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                        fontFamily: 'Cairo',
                      ),
                    ),
                   
                  ),
                ),
                SizedBox(
                  height: screenHeight    * 0.01,
                ),
           Padding(
                  padding: const EdgeInsets.symmetric( horizontal: 18.0),
                  child: Center(
                    child: Text(
                      ' لتجارة لعب الاطفال والهدايا ',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple[600],
                        fontFamily: 'Cairo',
                      ),
                    ),
                   
                  ),
                ),


                SizedBox(
                  height: screenHeight * 0.1,
                ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                                                Container(
                            width: screenWidth * 0.95,
                            height: screenHeight * 0.06,
                            color: Colors.transparent,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[900],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                  Get.to(() => LoginPage());
                              
                              },
                              label: Text(
                                ' تسجيل الدخول   ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cairo',
                                  color: Colors.white,
                                ),
                              ),
                              icon: Icon(Icons.login, color: Colors.white),
                            ),
                          ),
                          SizedBox( 
                              height: screenHeight * 0.02,
                          ),
                                
                                                                      Container(
                            width: screenWidth * 0.95,
                            height: screenHeight * 0.06,
                            color: Colors.transparent,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple[600],  
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              onPressed: () {
                               Get.to(() => Registerpage());
                              },
                              label: Text(
                                ' انشاء حساب جديد',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cairo',
                                  color: Colors.white,
                                ),
                              ),
                              icon: Icon(Icons.app_registration, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
