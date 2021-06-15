import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final bool isMe;
  final String profileImg;
  final String message;
  final int messageType;
  const ChatBubble({
    Key key, this.isMe, this.profileImg, this.message, this.messageType
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(isMe){
      return Container(
        padding: (messageType != 1 && messageType != 2)
          ? const EdgeInsets.only(right: 2.0, top: 2.0, bottom: 10.0)
          : const EdgeInsets.all(2.0),
        width: MediaQuery.of(context).size.width/2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Container(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 15.0, right: 15.0),
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: getMessageType(messageType)
                ),
                child: Text(
                  message,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 17
                  ),
                  maxLines: 20,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width - 100,
        padding: (messageType != 1 && messageType != 2)
            ? const EdgeInsets.only(right: 2.0, top: 2.0, bottom: 10.0)
            : const EdgeInsets.all(2.0),
        child: Stack(
          children: [
            if(messageType != 1 && messageType != 2)
              Positioned.fill(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Theme.of(context).hintColor.withOpacity(0.2)),
                        image: DecorationImage(image: NetworkImage(profileImg), fit: BoxFit.contain)),
                  ),
                ),
              ),
            Row(
              children: [
                SizedBox(width: 30),
                Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 15.0, right: 15.0),
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor.withOpacity(0.9),
                        borderRadius: getMessageType(messageType),
                        border: Border.all(color: Theme.of(context).hintColor.withOpacity(0.1)),
                      ),
                      child: Text(
                        message,
                        style: TextStyle(
                            color: Theme.of(context).brightness == Brightness.light
                                ? Theme.of(context).hintColor
                                : Colors.white,
                            fontSize: 17
                        ),
                        maxLines: 20,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    )
                ),
              ],
            )
          ],
        )
      );
    }
  }

  getMessageType(messageType){
    if(isMe){
      // start message
      if(messageType == 1){
        return BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(5),
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20)
        );
      }
      // middle message
      else if(messageType == 2){
        return BorderRadius.only(
            topRight: Radius.circular(5),
            bottomRight: Radius.circular(5),
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20)
        );
      }
      // end message
      else if(messageType == 3){
        return BorderRadius.only(
            topRight: Radius.circular(5),
            bottomRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20)
        );
      }
      // standalone message
      else{
        return BorderRadius.all(Radius.circular(20));
      }
    }
    // for sender bubble
    else{
      // start message
      if(messageType == 1){
        return BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(5),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20)
        );
      }
      // middle message
      else if(messageType == 2){
        return BorderRadius.only(
            topLeft: Radius.circular(5),
            bottomLeft: Radius.circular(5),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20)
        );
      }
      // end message
      else if(messageType == 3){
        return BorderRadius.only(
            topLeft: Radius.circular(5),
            bottomLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20)
        );
      }
      // standalone message
      else{
        return BorderRadius.all(Radius.circular(20));
      }
    }
  }
}