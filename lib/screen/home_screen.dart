import 'package:flutter/material.dart';
import 'package:hotel_booking_concept/common/icons.dart';
import 'package:hotel_booking_concept/common/stub_data.dart';
import 'package:hotel_booking_concept/common/theme.dart';
import 'package:hotel_booking_concept/parallax_page_view.dart';
import 'package:hotel_booking_concept/screen/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> hotelCategories = StubData().hotelCategories;
  final List<HotelCard> hotels = StubData().hotels;
  final List<EventCard> events = StubData().events;

  int checkedItem = 0;

  @override
  Widget build(BuildContext context) {
    final themeData = HotelConceptThemeProvider.get();
    return ScrollConfiguration(
      behavior: OverScrollBehavior(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).padding.top),
              SizedBox(height: 46),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0.0, 4.0),
                      color: themeData.highlightColor,
                      blurRadius: 24.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(HotelBookingConcept.ic_search),
                        hintText: "Where you want to go?",
                        hintStyle:
                            TextStyle(color: themeData.hintColor, fontSize: 14),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 10)),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 12),
                    Text("Hello Alex,",
                        style: themeData.textTheme.headline3),
                    const SizedBox(height: 8),
                    Text("Find your perfect places",
                        style: TextStyle(
                            fontSize: 24, color: themeData.primaryColorLight)),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Hotels",
                            style: TextStyle(
                                fontSize: 24,
                                color: themeData.primaryColorLight,
                                fontWeight: FontWeight.w600)),
                        Text("View all",
                            style: TextStyle(
                                fontSize: 12,
                                color: themeData.accentColor,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 32,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          checkedItem = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        height: double.infinity,
                        margin: EdgeInsets.only(
                            left: index == 0 ? 20 : 5, right: 5),
                        decoration: BoxDecoration(
                          color: index == checkedItem
                              ? themeData.accentColor
                              : themeData.unselectedWidgetColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              hotelCategories[index],
                              style: TextStyle(
                                  color: index == checkedItem
                                      ? Colors.white
                                      : themeData.accentColor),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: hotelCategories.length,
                ),
              ),
              const SizedBox(height: 10),
              ParallaxPageView(
                viewportFraction: 0.6,
                height: 360,
                data: hotels,
                onCardTap: (hotel) {
                  Navigator.of(context).push(
                    PageRouteBuilder<void>(
                      pageBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation) {
                        return AnimatedBuilder(
                            animation: animation,
                            builder: (BuildContext context, Widget child) {
                              return DetailScreen(
                                heroTag: "${hotel.cardTitle()}",
                                imageAsset: hotel.cardImageAsset(),
                              );
                            });
                      },
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Events",
                        style: TextStyle(
                            fontSize: 24,
                            color: themeData.primaryColorLight,
                            fontWeight: FontWeight.w600)),
                    Text("View all",
                        style: TextStyle(
                            fontSize: 12,
                            color: themeData.accentColor,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              ParallaxPageView(
                viewportFraction: 0.8,
                height: 180,
                data: events,
                onCardTap: (hotel) {
                  Navigator.of(context).push(
                    PageRouteBuilder<void>(
                      pageBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation) {
                        return AnimatedBuilder(
                            animation: animation,
                            builder: (BuildContext context, Widget child) {
                              return DetailScreen(
                                heroTag: "${hotel.cardTitle()}",
                                imageAsset: hotel.cardImageAsset(),
                              );
                            });
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
