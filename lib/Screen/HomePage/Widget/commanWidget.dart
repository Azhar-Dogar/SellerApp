import 'package:flutter/material.dart';
import '../../../Helper/Color.dart';
import '../../../Widget/routes.dart';

getAppBarHome(BuildContext context, String appName) {
  return AppBar(
    title: Text(
      appName,
      style: const TextStyle(
        color: grad2Color,
      ),
    ),
    backgroundColor: white,
    iconTheme: const IconThemeData(
      color: grad2Color,
    ),
  );
}

floatingBtn(BuildContext context) {
  return SizedBox(
    height: 40.0,
    width: 40.0,
    child: FittedBox(
      child: FloatingActionButton(
        backgroundColor: newPrimary,
        child: const Icon(
          Icons.add,
          size: 32,
          color: white,
        ),
        onPressed: () {
          Routes.navigateToAddProduct(context);
        },
      ),
    ),
  );
}
