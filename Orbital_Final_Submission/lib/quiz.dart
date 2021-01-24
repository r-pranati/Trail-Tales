import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionTile extends StatefulWidget {
  final String option, answer, correctAnswer, optionSelected;
  OptionTile(
      {@required this.optionSelected,
      @required this.correctAnswer,
      @required this.answer,
      @required this.option});
  @override
  _OptionTileState createState() => _OptionTileState();
}
 
class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    double swidth;
    double sheight;
    swidth = MediaQuery.of(context).size.width;
    sheight = MediaQuery.of(context).size.height;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        // width: swidth * 0.6,
        // height: 30, //sheight * 0.1,
        child: Row(
          children: [
            Container(
              height: 28,
              width: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: widget.answer == widget.optionSelected
                      ? widget.optionSelected == widget.correctAnswer
                          ? Colors.green.withOpacity(0.7)
                          : Colors.red.withOpacity(0.7)
                      : Colors.grey,
                  width: 1.5,
                ),
                color: widget.optionSelected == widget.answer
                    ? widget.optionSelected == widget.correctAnswer
                    ? Colors.green.withOpacity(0.7)
                    : Colors.red.withOpacity(0.7)
                    : Colors.white,
              borderRadius: BorderRadius.circular(24)
              ),
              child: Text(
                '${widget.option}',
                style: TextStyle(
                    color: widget.optionSelected == widget.answer
                        ? widget.correctAnswer == widget.optionSelected
                            ? Colors.white.withOpacity(0.7)
                            : Colors.white.withOpacity(0.7)
                        : Colors.grey),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              widget.answer,
              style: TextStyle(fontSize: 17, color: Colors.black54),
            ),
          ],
        ));
  }
}
