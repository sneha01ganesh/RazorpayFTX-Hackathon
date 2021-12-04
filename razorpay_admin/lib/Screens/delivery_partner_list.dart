import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_admin/Helpers/button.dart';
import 'package:razorpay_admin/Helpers/colors.dart';
import 'package:razorpay_admin/Helpers/style.dart';
import 'package:razorpay_admin/Helpers/textfield_deco.dart';
import 'package:razorpay_admin/Providers/delivery_persons.dart';
import 'package:razorpay_admin/Widgets/appbar_widget.dart';
import 'package:razorpay_admin/Widgets/dialogs.dart';

class DeliveryPartners extends StatefulWidget {
  static const pg = 'deliveryPartners';

  const DeliveryPartners({Key? key}) : super(key: key);

  @override
  _DeliveryPartnersState createState() => _DeliveryPartnersState();
}

class _DeliveryPartnersState extends State<DeliveryPartners> {
  // List _deliveryPartners = [];
  Dialogs dialogs = Dialogs();

  final TextEditingController _nameCtrl = TextEditingController(),
      _phoneCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _addDeliveryPartnerDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        final width = MediaQuery.of(context).size.width;

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              width * 0.03,
            ),
          ),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameCtrl,
                  decoration: TextFieldDecoration.rRectDecoration(
                    hint: 'Name',
                    width: width,
                  ),
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: width * 0.03),
                TextFormField(
                  controller: _phoneCtrl,
                  decoration: TextFieldDecoration.rRectDecoration(
                    hint: 'Phone No.',
                    width: width,
                  ).copyWith(counterText: ''),
                  maxLength: 10,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a Phone No.';
                    }
                    if (value.length != 10) {
                      return 'Enter a valid Phone No.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: width * 0.03),
                SolidButton(
                  name: 'Add',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final _details = {
                        'name': _nameCtrl.text.trim(),
                        'phone': _phoneCtrl.text.trim(),
                      };

                      await Provider.of<DeliveryPersons>(context, listen: false)
                          .addDeliveryPartner(
                        _details['name'] ?? "",
                        _details['phone'] ?? "",
                      )
                          .then((_) {
                        Navigator.pop(context);
                        _nameCtrl.clear();
                        _phoneCtrl.clear();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final provider = Provider.of<DeliveryPersons>(context, listen: false);

    if (_isInit && !provider.listFetched) {
      setState(() {
        _isLoading = true;
      });

      provider.fetchItems().then((_) {
        setState(() {
          _isLoading = false;
        });
      }).catchError((e) {
        setState(() {
          _isLoading = false;
        });
        dialogs.error(context: context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<DeliveryPersons>(context);
    final deliveryPersons = provider.items;

    return Scaffold(
      appBar: AppBarWidget.appBar(
        context: context,
        backIcon: true,
      ),
      body: Column(
        children: [
          SizedBox(height: width * 0.05),
          Text(
            'Your Delivery Partners',
            style: greenBoldText.copyWith(
              fontSize: width * 0.045,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: width * 0.07),
          InkWell(
            onTap: _addDeliveryPartnerDialog,
            child: Column(
              children: [
                Icon(
                  Icons.add,
                  color: green,
                  size: width * 0.06,
                ),
                Text(
                  'Add New',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: width * 0.035,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: width * 0.07),
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.04,
                    ),
                    shrinkWrap: true,
                    itemCount: deliveryPersons.length,
                    itemBuilder: (context, index) {
                      return DeliveryPartnerCard(
                        id: deliveryPersons[index].id,
                        name: deliveryPersons[index].name,
                        phone: deliveryPersons[index].phone.toString(),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}

class DeliveryPartnerCard extends StatelessWidget {
  const DeliveryPartnerCard({
    Key? key,
    this.id,
    this.name,
    this.phone,
  }) : super(key: key);

  final String? id;
  final String? name;
  final String? phone;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {},
      onLongPress: () {
        Dialogs().yesNoDialog(
          context,
          content: 'Do you want to delete this Delivery Partner?',
          yesFn: () async {
            Dialogs().dismiss(context);

            Dialogs().loading(context, content: 'Deleting...');

            await Provider.of<DeliveryPersons>(context, listen: false)
                .deleteDeliveryPartner(id ?? "")
                .then((_) {
              Dialogs().dismiss(context);
            }).catchError((e) {
              Dialogs().dismiss(context);
              Dialogs().error(context: context);
            });
          },
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            width * 0.035,
          ),
        ),
        elevation: width * 0.0045,
        margin: EdgeInsets.only(
          bottom: width * 0.03,
          left: width * 0.01,
          right: width * 0.01,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: width * 0.025,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$name'),
              SizedBox(height: width * 0.02),
              Text('+91 $phone'),
            ],
          ),
        ),
      ),
    );
  }
}
