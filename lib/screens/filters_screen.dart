import 'package:flutter/material.dart';
import 'package:meal_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.saveFilters, this.currentFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _GlutenFree = false;
  bool _LactoseFree = false;
  bool _Vegan = false;
  bool _Vegetarian = false;

  @override
  void initState() {
    _GlutenFree = (widget.currentFilters['gluten'])!;
    _LactoseFree = (widget.currentFilters['lactose'])!;
    _Vegan = (widget.currentFilters['vegen'])!;
    _Vegetarian = (widget.currentFilters['vegetarian'])!;
    super.initState();
  }

  Widget buildSwitchTitle(String? title, String? supTitle, bool currentValue,
      ValueChanged<bool>? updata) {
    return SwitchListTile(
      subtitle: Text(supTitle!),
      title: Text(title!),
      value: currentValue,
      onChanged: updata,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('filters'),
        actions: [
          IconButton(
            onPressed: (() {
              final Map<String, bool> selectedFilters = {
                'gluten': _GlutenFree,
                'lactose': _LactoseFree,
                'vegen': _Vegan,
                'vegetarian': _Vegetarian,
              };
              widget.saveFilters(selectedFilters);
            }),
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchTitle(
                  'Gluten - Free',
                  'Only include gluten-free meals',
                  _GlutenFree,
                  (value) {
                    setState(() {
                      _GlutenFree = value;
                    });
                  },
                ),
                buildSwitchTitle('Lactose - Free',
                    'Only include Lactose-free meals', _LactoseFree, (value) {
                  setState(() {
                    _LactoseFree = value;
                  });
                }),
                buildSwitchTitle("Vegan", 'Only include Vegan meals', _Vegan,
                    (value) {
                  setState(() {
                    _Vegan = value;
                  });
                }),
                buildSwitchTitle(
                    "Vegetarian", 'Only include Vegetarian meals', _Vegetarian,
                    (value) {
                  setState(() {
                    _Vegetarian = value;
                  });
                }),
              ],
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
