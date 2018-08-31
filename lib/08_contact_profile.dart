import 'package:flutter/material.dart';

import '00_base_page.dart';

class ContactProfilePage extends BasePage {
  ContactProfilePage({Key key, String title}) : super(key: key, title: title);

  final Contact contact = Contact(
      name: 'Ali Connors',
      avatar: 'images/contact_photo1.jpg',
      phones: [
        ContactPhone(type: ContactTypes.mobile, number: '(650)555-1234'),
        ContactPhone(type: ContactTypes.work, number: '(323)555-6789'),
        ContactPhone(type: ContactTypes.home, number: '(650)555-6789'),
      ],
      emails: [
        ContactEmail(type: ContactTypes.personal, address: 'ali_connors@example.com'),
        ContactEmail(type: ContactTypes.work, address: 'aliconnors@example.com'),
      ],
      locations: [
        ContactLocation(
          type: ContactTypes.home,
          street: '2000 Main Street',
          region: 'San Francisco, CA',
        ),
        ContactLocation(
          type: ContactTypes.work,
          street: '1600 Amphitheater Parkway',
          region: 'Mountain View, CA',
        ),
        ContactLocation(
          type: ContactTypes.jetTravel,
          street: '126 Severync Ave',
          region: 'Mountain View, CA',
        ),
      ],
      calendars: [
        ContactCalendar(name: 'Birthday', time: 'January 9th, 1989'),
        ContactCalendar(name: 'Wedding anniversary', time: 'June 21st, 2014'),
        ContactCalendar(name: 'First day in office', time: 'January 20th, 2015'),
        ContactCalendar(name: 'Last day in office', time: 'August 9th, 2015'),
      ]);

  @override
  _ContactProfilePageState createState() => _ContactProfilePageState();
}

enum AppBarBehavior {normal, pinned, floating, snapping}

class _ContactProfilePageState extends BasePageState<ContactProfilePage> {
  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final double _appBarHeight = 256.0;
  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: buildBody(context),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    final appBar = SliverAppBar(
      expandedHeight: _appBarHeight,
      pinned: _appBarBehavior == AppBarBehavior.pinned,
      floating: _appBarBehavior == AppBarBehavior.floating ||
          _appBarBehavior == AppBarBehavior.snapping,
      snap: _appBarBehavior == AppBarBehavior.snapping,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.edit),
          tooltip: 'Edit',
          onPressed: () {
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: const Text("Editing isn't supported in this screen."),
            ));
          },
        ),
        PopupMenuButton<AppBarBehavior>(
          onSelected: (value) { setState(() { _appBarBehavior = value; }); },
          itemBuilder: (context) => <PopupMenuItem<AppBarBehavior>>[
            const PopupMenuItem<AppBarBehavior>(
                value: AppBarBehavior.normal,
                child: const Text('App bar scrolls away')
            ),
            const PopupMenuItem<AppBarBehavior>(
                value: AppBarBehavior.pinned,
                child: const Text('App bar stays put')
            ),
            const PopupMenuItem<AppBarBehavior>(
                value: AppBarBehavior.floating,
                child: const Text('App bar floats')
            ),
            const PopupMenuItem<AppBarBehavior>(
                value: AppBarBehavior.snapping,
                child: const Text('App bar snaps')
            ),
          ],
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: Text(widget.contact.name),
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              widget.contact.avatar,
              fit: BoxFit.cover,
              height: _appBarHeight,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.0, -1.0),
                  end: Alignment(0.0, -0.4),
                  colors: <Color>[Color(0x60000000), Color(0x00000000)],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    final onContactItemPressed = (profile) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: const Text("This function isn't supported in this screen."),
      ));
    };
    final onContactItemButtonPressed = (profile) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: const Text("This function isn't supported in this screen."),
      ));
    };

    final sliverList = SliverList(
      delegate: SliverChildListDelegate(<Widget>[
        ContactProfileCategory(
          profiles: widget.contact.phones,
          category: ContactCategory.phone,
          onItemPressed: onContactItemPressed,
          onButtonPressed: onContactItemButtonPressed,
        ),
        ContactProfileCategory(
          profiles: widget.contact.emails,
          category: ContactCategory.email,
          onItemPressed: onContactItemPressed,
          onButtonPressed: onContactItemButtonPressed,
        ),
        ContactProfileCategory(
          profiles: widget.contact.locations,
          category: ContactCategory.location,
          onItemPressed: onContactItemPressed,
          onButtonPressed: onContactItemButtonPressed,
        ),
        ContactProfileCategory(
          profiles: widget.contact.calendars,
          category: ContactCategory.calendar,
          onItemPressed: onContactItemPressed,
          onButtonPressed: onContactItemButtonPressed,
        ),
      ]),
    );

    return CustomScrollView(slivers: <Widget>[appBar, sliverList]);
  }
}

enum ContactCategory { phone, email, location, calendar }

class ContactProfileItem extends StatelessWidget {
  const ContactProfileItem({
    @required this.profile,
    @required this.category,
    @required this.onItemPressed,
    @required this.onButtonPressed
  });

  final ContactProfile profile;
  final ContactCategory category;
  final VoidCallback onItemPressed;
  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) {
    List<String> items;
    String tooltip;
    IconData itemIconData;

    switch (category) {
      case ContactCategory.phone:
        itemIconData = Icons.message;
        tooltip = 'Send message';
        items = <String>[(profile as ContactPhone).number];
        break;
      case ContactCategory.email:
        itemIconData = Icons.email;
        tooltip = 'Send e-mail';
        items = <String>[(profile as ContactEmail).address];
        break;
      case ContactCategory.location:
        itemIconData = Icons.map;
        tooltip = 'Open map';
        items = <String>[
          (profile as ContactLocation).street,
          (profile as ContactLocation).region,
        ];
        break;
      case ContactCategory.calendar:
        itemIconData = null;
        tooltip = null;
        items = <String>[
          (profile as ContactCalendar).name,
          (profile as ContactCalendar).time,
        ];
        break;
    }

    if (profile.type != null) {
      items.add(profile.type);
    }

    final themeData = Theme.of(context);
    final columnChildren = items.map((item) {
      return Text(
        item,
        style: item != items.first && item == items.last
            ? themeData.textTheme.caption : null,
      );
    }).toList();

    final rowChildren = <Widget>[
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: columnChildren,
          ),
        )
      ),
      SizedBox(
        width: 48.0,
        height: 48.0,
        child: itemIconData == null ? null : IconButton(
          icon: Icon(itemIconData),
          color: themeData.primaryColor,
          tooltip: tooltip,
          onPressed: onButtonPressed,
        ),
      ),
    ];

    return InkWell(
      onTap: onItemPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: rowChildren,
        ),
      ),
    );
  }
}

typedef void OnContactItemPressed(ContactProfile);
typedef void OnContactItemButtonPressed(ContactProfile);

class ContactProfileCategory extends StatelessWidget {
  const ContactProfileCategory({
    @required this.profiles,
    @required this.category,
    @required this.onItemPressed,
    @required this.onButtonPressed
  });

  final List<ContactProfile> profiles;
  final ContactCategory category;
  final OnContactItemPressed onItemPressed;
  final OnContactItemButtonPressed onButtonPressed;

  @override
  Widget build(BuildContext context) {
    IconData _categoryIconData;
    switch (category) {
      case ContactCategory.phone:
        _categoryIconData = Icons.call;
        break;
      case ContactCategory.email:
        _categoryIconData = Icons.contact_mail;
        break;
      case ContactCategory.location:
        _categoryIconData = Icons.location_on;
        break;
      case ContactCategory.calendar:
        _categoryIconData = Icons.today;
        break;
    }

    final themeData = Theme.of(context);
    final leftIcon = Container(
      margin: const EdgeInsets.fromLTRB(12.0, 24.0, 0.0, 24.0),
      width: 48.0,
      height: 48.0,
      child: Icon(_categoryIconData, color: themeData.primaryColor),
    );
    final rightColumn = Expanded(
      child: Container(
        margin: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
        child: Column(
            children: profiles.map((profile) {
              return ContactProfileItem(
                profile: profile,
                category: category,
                onItemPressed: () => onItemPressed(profile),
                onButtonPressed: () => onButtonPressed(profile),
              );
            }).toList()),
      ),
    );

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: themeData.dividerColor)),
      ),
      child: DefaultTextStyle(
        style: themeData.textTheme.subhead,
        child: SafeArea(
          top: false,
          bottom: false,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[leftIcon, rightColumn],
          ),
        ),
      ),
    );
  }
}

// =============================================================================

class ContactTypes {
  static const String mobile = 'Mobile';
  static const String personal = 'Personal';
  static const String work = 'Work';
  static const String home = 'Home';
  static const String jetTravel = 'JetTravel';
}

abstract class ContactProfile {
  String type;
}

class ContactPhone implements ContactProfile {
  ContactPhone({this.type: ContactTypes.mobile, this.number});

  String type;
  String number;
}

class ContactEmail implements ContactProfile {
  ContactEmail({this.type: ContactTypes.personal, this.address});

  String type;
  String address;
}

class ContactLocation implements ContactProfile {
  ContactLocation({this.type: ContactTypes.home, this.street, this.region});

  String type;
  String street;
  String region;
}

class ContactCalendar implements ContactProfile {
  ContactCalendar({this.name, this.time});

  String type;
  String name;
  String time;
}

class Contact {
  Contact({
    @required this.name,
    @required this.avatar,
    this.phones,
    this.emails,
    this.locations,
    this.calendars,
  });

  String name;
  String avatar;
  List<ContactPhone> phones;
  List<ContactEmail> emails = [];
  List<ContactLocation> locations = [];
  List<ContactCalendar> calendars = [];
}