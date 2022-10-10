

import 'package:flutter/material.dart';
 import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';



class SplashScreen12 extends StatefulWidget {
  const SplashScreen12({Key? key}) : super(key: key);

  @override
  State<SplashScreen12> createState() => _SplashScreen12State();
}

class _SplashScreen12State extends State<SplashScreen12> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepPurpleAccent.withOpacity(.3),
        child:ListView.builder(
          itemCount: 10,
          itemBuilder: (context, position) {
            return _buildItemForList(position);
          },
        ),
      ),
    );


  }

  Widget _buildItemForList(int index) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 10,bottom: 10),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black87,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10))

      ),
      child: InkResponse(
        onTap: (){
          setState(() {

            _showToast(index.toString());
          });

        },
        child: Slidable(

          // Specify a key if the Slidable is dismissible.
          key: const ValueKey(0),

          // The start action pane is the one at the left or the top side.
          // startActionPane: ActionPane(
          //   // A motion is a widget used to control how the pane animates.
          //   motion: const ScrollMotion(),
          //
          //   // A pane can dismiss the Slidable.
          //  // dismissible: DismissiblePane(onDismissed: () {}),
          //
          //   // All actions are defined in the children parameter.
          //   children: const [
          //     // A SlidableAction can have an icon and/or a label.
          //     // SlidableAction(
          //     //   onPressed: doNothing,
          //     //   backgroundColor: Color(0xFFFE4A49),
          //     //   foregroundColor: Colors.white,
          //     //   icon: Icons.delete,
          //     //   label: 'Delete',
          //     // ),
          //     // SlidableAction(
          //     //   onPressed: doNothing,
          //     //   backgroundColor: Color(0xFF21B7CA),
          //     //   foregroundColor: Colors.white,
          //     //   icon: Icons.share,
          //     //   label: 'Share',
          //     // ),
          //   ],
          // ),

          // The end action pane is the one at the right or the bottom side.
          endActionPane:ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                // An action can be bigger than the others.
                flex: 1,
                // onPressed:(){} doNothing,
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                icon: Icons.archive,
                label: 'Archive'+index.toString(),
                onPressed: (BuildContext context) {

                  setState(() {
                    _showToast(index.toString());
                  });

                },
              ),
              Container(
                width: 80,

                decoration: const BoxDecoration(
                  color: Colors.amberAccent,

                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),

                  ),
                ),

                child: SlidableAction(
                  onPressed: (BuildContext context) {

                    setState(() {
                      _showToast(index.toString() +"No Save");
                    });

                  },
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  icon: Icons.save,
                  label: 'Save',
                ),
              ),

            ],
          ),

          // The child of the Slidable is what the user sees when the
          // component is not dragged.
          child:Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              ListTile(title: Text('Slide me- Slide me- Slide me- Slide me- Slide me-'+index.toString())),
              const SizedBox(
                height: 10,
              ),


            ],
          ),
        ),
      ),
    )

    ;
  }

  _showToast(String message) {

    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.deepPurpleAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void doNothing(BuildContext context) {

  }

}
