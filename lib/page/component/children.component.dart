import 'package:app_assisthelp/model/children.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ChildrenComponent extends StatefulWidget {
  final Children children;
  const ChildrenComponent({required this.children, super.key});

  @override
  State<ChildrenComponent> createState() => _ChildrenComponentState();
}

class _ChildrenComponentState extends State<ChildrenComponent> {
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.children.firstName!),
        subtitle: Text(widget.children.lastName!),
      ),
    );
  }
}