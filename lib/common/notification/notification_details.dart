import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import '../navigation_page/home_page.dart';
import '../navigation_page/navigation_bar_page.dart';
import 'notifications_deleted.dart';
import 'notifications_settings.dart';

class NotificationsDetailsScreen extends StatefulWidget {
  String _notificationId;
  String _notificationMessage;
  String _notificationMessageDate;

  NotificationsDetailsScreen(
    this._notificationId,
    this._notificationMessage,
    this._notificationMessageDate,
  ); //  const NotificationsDetailsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsDetailsScreen> createState() =>
      _NotificationsDetailsScreenState(
        this._notificationId,
        this._notificationMessage,
        this._notificationMessageDate,
      );
}

class _NotificationsDetailsScreenState
    extends State<NotificationsDetailsScreen> {
  String _notificationId;
  String notificationMessage;
  String _notificationMessageDate;

  _NotificationsDetailsScreenState(
    this._notificationId,
    this.notificationMessage,
    this._notificationMessageDate,
  );



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const SizedBox(
              height: 55,
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Container(
                  margin: new EdgeInsets.only(left: 30),
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: novalexxa_text_color,
                      size: 30.0,
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                      margin: new EdgeInsets.only(right: 10),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Notifications",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: novalexxa_text_color,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )),
                Container(
                  margin: const EdgeInsets.only(right: 30),
                  child: IconButton(
                    icon: const Icon(
                      Icons.settings,
                      size: 25,
                    ),
                    color: novalexxa_text_color,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NotificationsSettingsScreen()));
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: Stack(
                children: [
                  _buildMessageSection(),
                  Container(
                    margin: EdgeInsets.only(
                        left: 40, right: 10, bottom: 0, top: 0),
                    padding: EdgeInsets.only(
                        right: 15.0, top: 15, bottom: 15, left: 15),

                    width: 80,
                    height: 80,
                    decoration: new BoxDecoration(
                      color: notification_image_bg_color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    //   height: 150,
                    child: Image.asset(
                      "assets/images/idea.png",
                      fit: BoxFit.fill,
                    ),

                    // FadeInImage.assetNetwork(
                    //   fit: BoxFit.fill,
                    //   placeholder: 'assets/images/loading.png',
                    //   image:
                    //   "https://technofaq.org/wp-content/uploads/2017/03/image00-21.jpg",
                    //   imageErrorBuilder: (context, url, error) =>
                    //       Image.asset(
                    //         'assets/images/loading.png',
                    //         fit: BoxFit.fill,
                    //       ),
                    // ) ,
                  ),
                ],
              ),
            ),
            _buildBottomButtonSection(),
            SizedBox(
              height: 25,
            )
          ],
        ),

        // CustomScrollView(
        //   slivers: [
        //     SliverFillRemaining(
        //       hasScrollBody: false,
        //       child:
        //     ),
        //   ],
        // )

    );
  }

  Widget _buildMessageSection() {
    return Container(
      margin: EdgeInsets.only(right: 30.0, top: 40, bottom: 10, left: 30),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.35),
            blurRadius: 20.0, // soften the shadow
            spreadRadius: 0.0, //extend the shadow
            offset: const Offset(
              2.0, // Move to right 10  horizontally
              1.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      //   height: 150,
      child: Container(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 60),
        child: Column(
          children: [
            //teacher profile
            Expanded(child: Container(
              margin:
              EdgeInsets.only(left: 0.0, right: 0.0, top: 15, bottom: 0),
              child: SingleChildScrollView(
                child: Text(
                  notificationMessage,
                  style: TextStyle(
                      color: novalexxa_text_color,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),),

            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: EdgeInsets.only(
                    left: 0.0, right: 0.0, top: 20, bottom: 20),
                child: Text(
                  _dateTimeConvert(_notificationMessageDate)
                  ,
                  style: TextStyle(
                      color: intello_level_color,
                      fontSize: 10,
                      fontWeight: FontWeight.w400),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButtonSection() {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(child: _buildGotToHomeButton()),
        _buildTrashAltButton()
      ],
    );
  }

  Widget _buildGotToHomeButton() {
    return InkResponse(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    NavigationBarScreen(0, HomePageScreen())));
      },
      child: Container(
        margin: EdgeInsets.only(left: 30, right: 10, bottom: 0, top: 20),
        //width: 80,
        height: 45,
        decoration: new BoxDecoration(
          color: novalexxa_color,
          borderRadius: BorderRadius.circular(10),
        ),
        //   height: 150,
        child: Center(
          child: Text(
            "Go to Home",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrashAltButton() {
    return InkResponse(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NotificationsDeletedScreen()));
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 30, bottom: 0, top: 20),
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 0, top: 0),
        //width: 80,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.35),
              blurRadius: 20.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset: const Offset(
                2.0, // Move to right 10  horizontally
                1.0, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
        //   height: 150,
        child: Center(
          child: Icon(
            Icons.delete,
            color: novalexxa_color,
            size: 25.0,
          ),
        ),
      ),
    );
  }

  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }
  _dateTimeConvert(String dateString) {
    DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(dateString);
    String outputDateFormat = DateFormat('dd MMM,yyyy').format(parseDate);
    String outputTimeFormat = DateFormat('hh:mm a').format(parseDate);
   return outputDateFormat+" at "+outputTimeFormat;
  }
}
