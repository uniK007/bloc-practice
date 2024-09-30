import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}




1. There is a big difference in how we send facets in query and how the web sends the hits / query.
2. Initially we send all facets and web also do so.
3. But the difference is that for any query we're sending all of the facets as Payload data and web only sends the clicked facet as Payload data.
4. Initially we're receiving all the facets with all the options in the response.
5. If we chose any options from any facets or multiple facets, the story differs.
6. E.g. From Length facet, we chose single option, we receive two objects in response.
⦁	First object, will have only the single data for the facet we chose and with all the updated data for other unchecked facets.
⦁	Also for first object, the payload for facet is all facets.
⦁	Second object, the payload facet data is length with empty facet filter.
⦁	It'll have only the updated / prev. data for the selected /checked facet where we chose the option.
7. Let's suppose we choose another option from same Length facet.
⦁	Now, the payload data for first hit is all facets along with facetFilters as the previosly chosen facet length option and the current length option.
⦁	The second searchHit payload will be the facet i.e. Length as String and it's without the facetFilter.
⦁	The response will have two objects as same before.
⦁	First object will contain all unchecked facet's updated data according to the selection and for the checked facet i.e. length, it consists of two option the prev. and current selected length option.
⦁	Second object, It'll have only the updated / prev. data for the selected /checked facet where we chose the option.
⦁	This is all that goes in a single API request.
8. Now, Let's chose from another facet i.e. Brand Facet.
⦁	Now, for the first hit, the payload will be with all facets and facetFilters: [["brand:Makita"],["length:114","length:172"]] 
⦁	The First object contains only the selected brand and for length it'll have both the prev. selected length options: {114: 2, 172: 3}  and rest of the unchecked facet will have the updated data according to the selection.
⦁	For second hit, the payload will be facetFilters: [["length:114","length:172"]] and facets: brand.
⦁	The second object, will have brand : {Makita: 5, HiKOKI: 2, Bosch: 1} that is all the sorted prev. options from which the brand facet option is selected.
⦁	For the third hit, the payload will be facetFilters: [["brand:Makita"]]  and facets: length.
⦁	For the third object, the facet data will be only the length facet with all the updated length options according to the selection of prev. facet options. It'll have updated data for the length that includes prev. selected options.

