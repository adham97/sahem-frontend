
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../generated/l10n.dart';
import '../pages/chat.dart';

import '../controllers/chat_users_controller.dart';
import '../repository/settings_repository.dart';

class ChatUserWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  ChatUserWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _ChatUserWidgetState createState() => _ChatUserWidgetState();
}

class _ChatUserWidgetState extends StateMVC<ChatUserWidget> {
  ChatUsersController _con;
  _ChatUserWidgetState() : super(ChatUsersController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => widget.parentScaffoldKey.currentState.openDrawer(),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: ValueListenableBuilder(
          valueListenable: setting,
          builder: (context, value, child) {
            return Text(
              S.of(context).chat,
              style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
            );
          },
        ),
      ),
      body: Container(
        child: ListView.builder(
            padding: EdgeInsets.only(left: 20, right: 20, top: 15),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: _con.chatUsers.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  print('online : ${_con.chatUsers.elementAt(index).user.online}');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatWidget(
                       user: _con.chatUsers.elementAt(index).user,
                      )
                    )
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 50,
                        height: 50,
                        child: Stack(
                          children: <Widget>[
                            _con.chatUsers.last.user.id != null
                            ? Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage( _con.chatUsers.elementAt(index).user.image),
                                    fit: BoxFit.cover
                                ),
                              ),
                            )
                            : Container(),
                            _con.chatUsers.elementAt(index).user.online
                            ? Positioned(
                              top: 35,
                              left: 35,
                              child: Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                    border:
                                    Border.all(color: Colors.white, width: 3)),
                              ),
                            )
                            : Container()
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${_con.chatUsers.elementAt(index).user.firstName} ${_con.chatUsers.elementAt(index).user.lastName}',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 135,
                            child: Text(
                              '${DateFormat.jm('${setting.value.mobileLanguage.value}').format(_con.chatUsers.elementAt(index).time)} - ${_con.chatUsers.elementAt(index).content}',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black.withOpacity(0.8)
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
}
