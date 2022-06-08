
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nova_lexxa/common/money_option/send_money/send_money_swipe_to_pay_page.dart';
import 'package:nova_lexxa/common/static/Colors.dart';




class EmailUsPageScreen extends StatefulWidget {

  @override
  State<EmailUsPageScreen> createState() => _EmailUsPageScreenState();
}

class _EmailUsPageScreenState extends State<EmailUsPageScreen> {

  TextEditingController? _sendMoneyMessageController = TextEditingController();
  TextEditingController? _sendTopicController = TextEditingController();
   int _customTopic=0;

  String topicName="Select Topic";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white ,
      body:CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const SizedBox(
                  height: 55,
                ),

                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Container(
                      margin: new EdgeInsets.only(left: 30,right: 20),
                      child: InkResponse(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: intello_input_text_color,
                          size: 30.0,
                        ),
                      ),
                    ),

                    Expanded(
                        child: toolBarDesign()
                    ),

                  ],
                ),

                Container(

                  alignment: Alignment.center,
                  margin: new EdgeInsets.only(left: 30,right: 30,top: 50),
                  decoration: BoxDecoration(
                      color:search_send_money_box_color,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                      padding: EdgeInsets.only(left: 10.0, top: 15,bottom: 15, right: 10),
                      child:Align(alignment: Alignment.topCenter,
                        child: _buildDropDownMenu(),
                      )


                  ),
                ),
                if(_customTopic==1)...{
                  SizedBox(height: 30,),
                  userInputCustomTopic(_sendTopicController!, 'Enter your Topic', TextInputType.text,),
                },

                SizedBox(height: 30,),
                //message section

                userInputMessage(_sendMoneyMessageController!, 'Enter your message', TextInputType.text,),

                Expanded(child:  Align(
                    alignment: Alignment.bottomCenter,
                    child: Wrap(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 40, top: 40, right: 40, bottom: 0),
                          child:  Align(
                            alignment: Alignment.topCenter,
                            child: _buildSendMessageButton(),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 40, top: 10, right: 40, bottom: 0),
                          child:  Align(
                            alignment: Alignment.topCenter,
                            child:  _buildCancelButton(),
                          ),
                        ),
                        Container(height: 20,)
                      ],
                    )
                ),)

              ],
            ),
          ),
        ],
      )

    );
  }

  Widget toolBarDesign() {
    return Padding(padding: EdgeInsets.only(right:00,top: 10,left: 00,bottom: 10),
      child:  Row(
        children: [

          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 42,
              height: 42,


              margin:const EdgeInsets.only(left:0, top: 00, right: 15, bottom: 00),
              // padding:const EdgeInsets.only(left:10, top: 10, right: 10, bottom: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(27.5),
                child: Container(
                    color:hint_color,
                    child: FadeInImage.assetNetwork(
                      fit: BoxFit.fill,
                      placeholder: 'assets/images/empty.jpg',
                      image: "https://i.pinimg.com/236x/44/59/80/4459803e15716f7d77692896633d2d9a--business-headshots-professional-headshots.jpg",
                      imageErrorBuilder: (context, url, error) =>
                          Image.asset(
                            'assets/images/empty.jpg',
                            fit: BoxFit.fill,
                          ),
                    )),
              ),

            ),
          ),
          Expanded(child:Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child:Text(
                  "Send us message",
                  style: TextStyle(
                      color: novalexxa_text_color,
                      fontSize: 20,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w600),
                ),
              ),

              Flex(direction: Axis.horizontal,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Lorem Ipsum is simply",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.4,
                          color: novalexxa_hint_text_color,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                  ),

                ],
              )

            ],
          ),),

          SizedBox(width: 10,)

        ],
      ),
    );
  }

  Widget userTopicDropDownSection() {
    return Row(
      children: [

        Expanded(child:Center(
          child: Text(
              topicName
          ),)
        ),

        Icon(
          Icons.arrow_drop_down,
          color:intello_input_text_color,
          size: 25.0,
        ),


      ],
    );
  }

  Widget userInputMessage(TextEditingController _controller, String hintTitle, TextInputType keyboardType,) {
    return  Container(
      margin: new EdgeInsets.only(left: 30,right: 30,top: 20),
      decoration: BoxDecoration(
          color:search_send_money_box_color,

          borderRadius: BorderRadius.circular(10)),
      child:  Padding(
          padding: const EdgeInsets.only(left: 25.0, top: 0,bottom: 0, right: 20),
          child: TextField(
            minLines: 6,
            maxLines: 30,
            keyboardType: TextInputType.multiline,
            controller: _controller,
            autocorrect: false,
            enableSuggestions: false,
            cursorColor:intello_input_text_color,
            style: TextStyle(
                color:intello_input_text_color,
                fontSize: 17,
            ),
            autofocus: false,

            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintTitle,
              hintStyle: const TextStyle(fontSize: 15, color:hint_color, fontStyle: FontStyle.normal),
            ),

          )

      ),
    );
  }

  Widget userInputCustomTopic(TextEditingController _controller, String hintTitle, TextInputType keyboardType,) {
    return  Container(
      margin: new EdgeInsets.only(left: 30,right: 30,top: 20),
      decoration: BoxDecoration(
          color:search_send_money_box_color,

          borderRadius: BorderRadius.circular(10)),
      child:  Padding(
          padding: const EdgeInsets.only(left: 25.0, top: 0,bottom: 0, right: 20),
          child: TextField(
            minLines: 1,
            maxLines: 3,
            keyboardType: TextInputType.multiline,
            controller: _controller,
            autocorrect: false,
            enableSuggestions: false,
            cursorColor:intello_input_text_color,
            style: TextStyle(
              color:intello_input_text_color,
              fontSize: 17,
            ),
            autofocus: false,

            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintTitle,
              hintStyle: const TextStyle(fontSize: 15, color:hint_color, fontStyle: FontStyle.normal),
            ),

          )

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

  Widget _buildDropDownMenu() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(

        customButton: Container(
          child:userTopicDropDownSection(),
        ),
        // openWithLongPress: true,
        customItemsIndexes: const [4],
        customItemsHeight: 8,
        itemHeight: 55.0,
        items: [
          ...MenuItems.firstItems.map(
                (item) =>
                DropdownMenuItem<MenuItem>(
                  value: item,
                  child: _buildDropDownItemDesign(item),
                ),
          ),
          const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
        ],

       // itemHeight: 40,
        itemPadding: const EdgeInsets.only(left: 10, right: 10),
        //dropdownWidth: 160,
        dropdownPadding: const EdgeInsets.symmetric(vertical: 0),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
        ),
        dropdownElevation: 8,
        offset: const Offset(0, 0),


        onChanged: (value) {
          switch (value as MenuItem) {
            case MenuItems.CustomTopic:
              setState(() {
                topicName="Custom Topic";
                _customTopic=1;
              });

              //Do something
              break;
            case MenuItems.Topic1:
              setState(() {
                topicName="Topic 1";
                _customTopic=0;
              });
              //Do something
              break;
            case MenuItems.Topic2:
              setState(() {
                topicName="Topic 2";
                _customTopic=0;
              });
              break;
            case MenuItems.Topic3:
              setState(() {
                topicName="Topic 3";
                _customTopic=0;
              });
              break;
          }
          // MenuItems.onChanged(context, value as MenuItem);
        },

      ),
    );
  }

   Widget _buildDropDownItemDesign(MenuItem item) {
    return Container(

      height: 55,
      child: Column(
        children: [
          Expanded(child:Row(
            children: [
              SizedBox(width: 10,),
              Align(
                alignment: Alignment.centerLeft,
                child:  Text(
                  item.text,
                  style: const TextStyle(
                    color: intello_input_text_color,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          )),
          Container(color: select_country_search_box_border_color,
          height: 1,
          )
        ],
      ),
    );
  }

  Widget _buildSendMessageButton() {
    return Container(
      margin: const EdgeInsets.only(left: 00.0, right: 00.0),
      child: ElevatedButton(
        onPressed: () {

          Navigator.of(context).pop();
        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7))),
        child: Ink(

          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [novalexxa_color, novalexxa_color],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(7.0)
          ),
          child: Container(

            height: 50,
            alignment: Alignment.center,
            child:  Text(
              "Send Message",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'PT-Sans',
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildCancelButton() {
    return InkWell(
      onTap: (){
       // Navigator.push(context,MaterialPageRoute(builder: (context)=>LogInScreen()));

      },
      child: Container(

        height: 50,
        alignment: Alignment.center,
        child:  Text(
          "Cancel",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: novalexxa_text_color,
          ),
        ),
      ),
    );
  }

}

class MenuItem {
  final String text;
  const MenuItem({
    required this.text,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [CustomTopic, Topic1, Topic2,Topic3];

  static const CustomTopic = MenuItem(text: 'Custom Topic',);
  static const Topic1 = MenuItem(text: 'Topic 1',);
  static const Topic2 = MenuItem(text: 'Topic 2', );
  static const Topic3 = MenuItem(text: 'Topic 3',);

}