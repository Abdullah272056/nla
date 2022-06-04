
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'notification_details.dart';
import 'notifications_settings.dart';



class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white ,
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
                  )
              ),

              Container(
                margin: const EdgeInsets.only(right: 30),
                child:IconButton(
                  icon: const Icon(Icons.settings,
                  size: 25,
                  ),
                  color: novalexxa_text_color,
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>NotificationsSettingsScreen()));

                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),

          Expanded(child:  ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 10,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return _buildNotificationItemForList();
              }),)


        ],
      ),
    );
  }




  Widget _buildNotificationItemForList() {
    return InkResponse(
      onTap: (){
        // _showToast("ok");
         Navigator.push(context,MaterialPageRoute(builder: (context)=>NotificationsDetailsScreen("12")));
      },
      child:
      Container(
        margin: EdgeInsets.only(right: 20.0, top: 10, bottom: 10, left: 20),
        //width: 180,
        decoration: new BoxDecoration(
          color:Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(

            color:Colors.grey.withOpacity(.25),
            //  blurRadius: 20.0, // soften the shadow
            blurRadius:20, // soften the shadow
            spreadRadius: 0.0, //extend the shadow
            offset: Offset(
              2.0, // Move to right 10  horizontally
              1.0, // Move to bottom 10 Vertically
            )
          )],
        ),
        //   height: 150,
        child:Container(
          margin: EdgeInsets.only(right: 10.0, top: 10, bottom: 10, left: 10),
          //color: Colors.white,
          child: SizedBox(
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Container(
                //  margin:  EdgeInsets.only(left: 10, right: 10,bottom: 10,top: 10),
                  padding: EdgeInsets.only(right: 12.0,top: 12,bottom: 12,left: 12),

                  width: 65,
                  height: 65,
                  decoration: new BoxDecoration(
                    color:notification_image_bg_color,
                    borderRadius: BorderRadius.circular(10),

                  ),
                  //   height: 150,
                  child:Image.asset("assets/images/idea.png",
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

                SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Flex(
                        direction: Axis.vertical,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Flex(
                              direction: Axis.horizontal,
                              children:  [
                                Expanded(
                                  child: Text(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color:novalexxa_text_color,
                                        // color: Colors.intello_text_color,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                    softWrap: false,
                                    maxLines: 2,
                                  ),


                                ),
                              ],
                            ),

                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Flex(
                              direction: Axis.horizontal,
                              children:  [
                                Expanded(
                                  child: Text(
                                    "06 Jun,2020 at 04:10 Pm",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(

                                        color:intello_level_color,
                                        // color: Colors.intello_text_color,
                                        fontSize: 11,
                                        fontWeight: FontWeight.normal),
                                    softWrap: false,
                                    maxLines: 2,
                                  ),


                                ),
                              ],
                            ),

                          ),

                        ],
                      ),
                    )),
              ],
            ),
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

}

