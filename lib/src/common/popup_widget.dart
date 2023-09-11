import 'package:flutter/material.dart';

class PopUp extends StatelessWidget {
  final String title;
  final bool isError;
  const PopUp({
    super.key,
    this.title = '',
    this.isError = true,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        content: Builder(builder: (context) {
          return Container(
              width: 330,
              height: 130,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 35, right: 35, top: 35, bottom: 20),
                    child: Column(children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ]),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: isError ? Colors.red : Colors.green,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(16.0),
                            bottomLeft: Radius.circular(16.0),
                          )),
                      width: double.infinity,
                      height: 40,
                      child: Center(
                        child: Text(
                          "Close",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  )
                ],
              ));
        }));
  }
}
