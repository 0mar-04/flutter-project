import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditDeleteServicePage extends StatefulWidget {
  final String serviceId;

  const EditDeleteServicePage({Key? key, required this.serviceId})
      : super(key: key);

  @override
  _EditDeleteServicePageState createState() => _EditDeleteServicePageState();
}

class _EditDeleteServicePageState extends State<EditDeleteServicePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _serviceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _specialistNameController = TextEditingController();
  DateTime? _datetime;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchServiceDetails();
  }

  @override
  void dispose() {
    _locationController.dispose();
    _serviceController.dispose();
    _descriptionController.dispose();
    _specialistNameController.dispose();
    super.dispose();
  }

  Future<void> _fetchServiceDetails() async {
    setState(() {
      _isLoading = true;
    });

    try {
      DocumentSnapshot doc =
      await _firestore.collection('serviceinfo').doc(widget.serviceId).get();
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

      if (data != null) {
        setState(() {
          _locationController.text = data['location'] ?? '';
          _serviceController.text = data['service'] ?? '';
          _descriptionController.text = data['servicedescription'] ?? '';
          _specialistNameController.text = data['specialistname'] ?? '';
          _datetime = (data['datetime'] as Timestamp).toDate();
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading service details: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateService() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await _firestore.collection('serviceinfo').doc(widget.serviceId).update({
        'location': _locationController.text,
        'service': _serviceController.text,
        'servicedescription': _descriptionController.text,
        'specialistname': _specialistNameController.text,
        'datetime': _datetime,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Service updated successfully!')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating service: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteService() async {
    bool confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Delete Service',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text('Are you sure you want to delete this service?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    ) ??
        false;

    if (!confirm) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await _firestore.collection('serviceinfo').doc(widget.serviceId).delete();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Service deleted successfully!')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting service: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Edit/Delete Service'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: _deleteService,
          ),
        ],
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Enter a location' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _serviceController,
                decoration: InputDecoration(
                  labelText: 'Service',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Enter a service' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _specialistNameController,
                decoration: InputDecoration(
                  labelText: 'Specialist Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              ListTile(
                title: Text(
                  _datetime == null
                      ? 'Select Date/Time'
                      : 'Date/Time: ${_datetime.toString()}',
                ),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _datetime ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );

                  if (pickedDate != null) {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          _datetime ?? DateTime.now()),
                    );

                    if (pickedTime != null) {
                      setState(() {
                        _datetime = DateTime(
                          pickedDate.year,
                          pickedDate.month,
                          pickedDate.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _updateService,
                child: Text('Update Service'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.arrow_back, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
