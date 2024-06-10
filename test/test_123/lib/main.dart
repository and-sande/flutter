import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  setUrlStrategy(PathUrlStrategy()); // For PWA support
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Utepils Prices',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.pressStart2pTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _tabs = [OverviewTab(), MapTab(), SubmitTab()];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Utepils'),
      ),
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Overview',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Submit',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

class OverviewTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search bars...',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DataTable(
              columns: [
                DataColumn(label: Text('Bar')),
                DataColumn(label: Text('Price')),
                DataColumn(label: Text('Avg Rating')),
                DataColumn(label: Text('Min Age')),
                DataColumn(label: Text('Updated')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('Example Bar')),
                  DataCell(Text('100 NOK')),
                  DataCell(Text('★★★☆☆')),
                  DataCell(Text('20')),
                  DataCell(Text('2024-01-01')),
                ]),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Rate Bars',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 10),
          RateBarForm(),
          SizedBox(height: 20),
          SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            title: ChartTitle(text: 'Beer Prices'),
            legend: Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CartesianSeries>[
              ColumnSeries<BeerData, String>(
                dataSource: getChartData(),
                xValueMapper: (BeerData data, _) => data.barName,
                yValueMapper: (BeerData data, _) => data.price,
                name: 'Price',
                color: Colors.red,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class RateBarForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            items: [
              DropdownMenuItem(value: 'Example Bar', child: Text('Example Bar')),
            ],
            onChanged: (value) {},
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Rating',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: Text('Submit Rating'),
          ),
        ],
      ),
    );
  }
}

class MapTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Map goes here'),
    );
  }
}

class SubmitTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Add a New Bar With the Lowest Beer Price!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 20),
            Placeholder(fallbackHeight: 200), // Placeholder for the map
            SizedBox(height: 10),
            Text(
              'Please set the marker precisely on the bar\'s location on the map before submitting.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            SubmitBarForm(),
          ],
        ),
      ),
    );
  }
}

class SubmitBarForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Bar Name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Beer Price',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Age Limit',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Rating (Optional)',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'City Name',
              border: OutlineInputBorder(),
            ),
            readOnly: true,
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}

List<BeerData> getChartData() {
  final List<BeerData> chartData = [
    BeerData('Bar1', 100),
    BeerData('Bar2', 120),
    BeerData('Bar3', 90),
  ];
  return chartData;
}

class BeerData {
  BeerData(this.barName, this.price);
  final String barName;
  final double price;
}
