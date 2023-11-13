
import 'package:flutter/material.dart';
import '../../services/database.dart';
import '../models/resource.dart';


class ResourceForm extends StatelessWidget {
  ResourceForm({super.key, required this.resource});

  Resource resource = Resource.newResource();
  final formKey = GlobalKey<FormState>();

  void updateDatabase(BuildContext context) {
    final form = formKey.currentState;
    if (form!.validate()) {
      try {
        form.save();
        Database().updateDatabaseEntry(resource);
        Navigator.pop(context);
      } catch (e) {}
    }
  }

  void displayCalendar(BuildContext context, TextEditingController controller){
    showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.utc(2010),
        lastDate: DateTime.utc(2050)).then((value) {
          if(value==null) return;
          List<String> date = value.toString().split(' ');
          controller.text = date[0];
    });
  }


  @override
  Widget build(BuildContext context) {
    final textController1;
    final textController2;
    if(resource.id.isEmpty){
      textController1 = TextEditingController();
      textController2 = TextEditingController();
    } else {
      final dates = resource.valid.split(' - ');
      textController1 = TextEditingController(text: dates[0]);
      textController2 = TextEditingController(text: dates[1]);
    }


    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Organization'),
              initialValue: resource.org,
              validator: (value) =>
              value!.isEmpty
                  ? 'Field cannot be Empty'
                  : null,
              onSaved: (value) => resource.org = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Type'),
              initialValue: resource.type,
              validator: (value) =>
              value!.isEmpty
                  ? 'Field cannot be Empty'
                  : null,
              onSaved: (value) => resource.type = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Place'),
              initialValue: resource.place,
              validator: (value) =>
              value!.isEmpty
                  ? 'Field cannot be Empty'
                  : null,
              onSaved: (value) => resource.place = value!,
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    onTap: () {displayCalendar(context, textController1);},
                    decoration: InputDecoration(labelText: 'Validity'),
                    validator: (value) => value!.isEmpty
                      ? 'Field cannot be Empty'
                      : null,
                    onSaved: (value) => resource.valid = value!,
                    controller: textController1,
              ),
                ),
                Flexible(
                  child: TextFormField(
                    onTap: () {displayCalendar(context, textController2);},
                    decoration: InputDecoration(labelText: 'Validity'),
                    validator: (value) => value!.isEmpty
                        ? 'Field cannot be Empty'
                        : null,
                    onSaved: (value) => resource.valid += ' - ${value!}',
                    controller: textController2,
                  ),
                ),]
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Photo'),
              initialValue: resource.photo,
              validator: (value) =>
              value!.isEmpty
                  ? 'Field cannot be Empty'
                  : null,
              onSaved: (value) => resource.photo = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Logo'),
              initialValue: resource.logo,
              validator: (value) =>
              value!.isEmpty
                  ? 'Field cannot be Empty'
                  : null,
              onSaved: (value) => resource.logo = value!,
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: () async {
              updateDatabase(context);
            },
                child: Text('Update'))
          ],
        ),
      ),
    );
  }
}