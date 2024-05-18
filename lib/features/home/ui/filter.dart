import '../../../exports.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<SortBy> sortBy = [
    SortBy(title: 'Most recent', value: SortCriteria.mostRecent),
    SortBy(title: 'Lowest price', value: SortCriteria.lowestPrice),
    SortBy(title: 'Highest reviews', value: SortCriteria.highestReviews),
  ];
  List<Gender> gender = [
    Gender(title: 'Man', value: 'male'),
    Gender(title: 'Woman', value: 'female'),
    Gender(title: 'Unisex', value: 'unisex'),
  ];
  List<ColorItems> color = [
    ColorItems(name: 'Black', color: '#000000'),
    ColorItems(name: 'White', color: '#FFFFFF'),
    ColorItems(name: 'Red', color: '#FF0000')
  ];
  late FilterCubit _filterCubit;
  late BrandCubit _brandCubit;

  @override
  void initState() {
    _brandCubit = context.read<BrandCubit>();
    _filterCubit = context.read<FilterCubit>();
    _brandCubit.fetchBrands();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productState = context.read<ProductCubit>().state;
    if (productState is ProductLoaded) {
      //Initialize to ensure consistency
      context.read<FilterCubit>().updateBrand(productState.selectedBrand);
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: AppText.medium(
          'Filter',
          fontSize: 16,
        ),
        backgroundColor: Colors.grey[100],
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<BrandCubit, BrandState>(
        builder: (context, brandState) {
          if (brandState is BrandLoaded) {
            var brands = brandState.brands.sublist(1);
            return BlocBuilder<FilterCubit, FilterState>(
              builder: (context, filterState) {
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.medium(
                                'Brands',
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              BlocBuilder<ProductCubit, ProductState>(
                                builder: (context, productState) {
                                  return Container(
                                    height: 110,
                                    padding: const EdgeInsets.only(left: 15),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: brands.length,
                                      itemBuilder: (context, index) {
                                        var brand = brands[index];
                                        final productCount =
                                            brandState.brandCounts[brand.id] ??
                                                0;
                                        final isSelected =
                                            filterState.brand == brand.id;
                                        return BrandFilterWidget(
                                          brandName: brand.name,
                                          imageUrl: brand.imageUrl,
                                          isSelected: isSelected,
                                          onTap: () => _filterCubit
                                              .updateBrand(brand.id),
                                          productCount: productCount,
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              AppText.medium(
                                'Price Range',
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              RangeSlider(
                                values: RangeValues(
                                  filterState.minPrice,
                                  filterState.maxPrice,
                                ),
                                min: 0,
                                max: 1000,
                                divisions: 100,
                                labels: RangeLabels(
                                  '\$${filterState.minPrice.round()}',
                                  '\$${filterState.maxPrice.round()}',
                                ),
                                activeColor: Colors.black,
                                inactiveColor: Colors.black38,
                                onChanged: (RangeValues values) {
                                  _filterCubit.updatePriceRange(
                                    values.start,
                                    values.end,
                                  );
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'Min: \$${filterState.minPrice.round()}'),
                                  Text(
                                      'Max: \$${filterState.maxPrice.round()}'),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              AppText.medium(
                                'Sort By',
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 40,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: sortBy.length,
                                  itemBuilder: (context, index) {
                                    var item = sortBy[index];
                                    bool selected =
                                        _filterCubit.state.sortCriteria ==
                                            item.value;
                                    return GestureDetector(
                                      onTap: () => _filterCubit
                                          .updateSortCriteria(item.value),
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(right: 15),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        decoration: selected
                                            ? BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              )
                                            : BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border.all(
                                                  color: ColorName.mainGrey,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                        child: Center(
                                          child: AppText.medium(
                                            item.title,
                                            color: selected
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              AppText.medium(
                                'Gender',
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 40,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: gender.length,
                                  itemBuilder: (context, index) {
                                    var item = gender[index];
                                    bool selected =
                                        _filterCubit.state.gender == item.value;
                                    return GestureDetector(
                                      onTap: () =>
                                          _filterCubit.updateGender(item.value),
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(right: 15),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        decoration: selected
                                            ? BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              )
                                            : BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border.all(
                                                  color: ColorName.mainGrey,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                        child: Center(
                                          child: AppText.medium(
                                            item.title,
                                            color: selected
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              AppText.medium(
                                'Color',
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 40,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: color.length,
                                  itemBuilder: (context, index) {
                                    var item = color[index];
                                    bool selected =
                                        _filterCubit.state.color == item.color;
                                    return GestureDetector(
                                      onTap: () =>
                                          _filterCubit.updateColor(item.color),
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(right: 15),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        decoration: selected
                                            ? BoxDecoration(
                                                // color: Colors.transparent,
                                                border: Border.all(
                                                  color: Colors.black,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              )
                                            : BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border.all(
                                                  color: ColorName.mainGrey,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: Card(
                                                color: _getColorFromHex(
                                                    item.color),
                                                shape: const CircleBorder(),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            AppText.medium(
                                              item.name,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (brandState is BrandError) {
            return Center(child: Text(brandState.message));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<FilterCubit, FilterState>(
        builder: (context, state) {
          final filterCount = _filterCubit.activeFiltersCount();
          return Container(
            height: 90,
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => _filterCubit.resetFilters(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                    child: AppText.medium(
                      filterCount > 0
                          ? 'Reset Filters ($filterCount)'
                          : 'Reset Filters',
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<ProductCubit>().applyFilters();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: AppText.medium(
                      'APPLY',
                      color: ColorName.whiteColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}

class ColorItems {
  final String name;
  final String color;
  ColorItems({
    required this.name,
    required this.color,
  });
}

class SortBy {
  final String title;
  final SortCriteria value;
  SortBy({
    required this.title,
    required this.value,
  });
}

class Gender {
  final String title;
  final String value;

  Gender({
    required this.title,
    required this.value,
  });
}
