import 'package:flutter/material.dart';
import 'package:foodage/ui/extensions.dart';
import 'package:foodage/ui/widgets/fdg_ratio.dart';

class PhotoContainer extends StatelessWidget {

  final WidgetTapCallback onRemovePressed;

  PhotoContainer ({ this.onRemovePressed });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: FDGRatio(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromRGBO(100, 100, 100, 1),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                right: 10,
                top: -8,
                child: Container(
                  width: 20,
                  height: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Material(
                      color: Theme.of(context).primaryColor,
                      child: InkWell(
                        child: Container(
                          child: Center(
                            child: Icon(Icons.close, color: Colors.white, size: 14),
                          ),
                        ),
                        onTap: () => onRemovePressed(context),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}