import 'package:awesome_app/core/widgets/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_app/image_pexel/bloc/image_provider.dart';
import 'package:awesome_app/image_pexel/screens/image_detail_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:awesome_app/image_pexel/models/image_data.dart'; // Import the new models file

class ImageListScreen extends StatefulWidget {
  const ImageListScreen({super.key});

  @override
  _ImageListScreenState createState() => _ImageListScreenState();
}

class _ImageListScreenState extends BaseState<ImageListScreen> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<ImageProviderBloc>().add(FetchImages(isNextPage: true));
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            title: const Text('Awesome App'),
            floating: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.grid_view),
                onPressed: () {
                  context
                      .read<ImageProviderBloc>()
                      .add(ChangeViewType(ViewType.grid));
                },
              ),
              IconButton(
                icon: const Icon(Icons.list),
                onPressed: () {
                  context
                      .read<ImageProviderBloc>()
                      .add(ChangeViewType(ViewType.list));
                },
              ),
            ],
          ),
          BlocBuilder<ImageProviderBloc, ImageProviderState>(
            builder: (context, state) {
              if (state.images.isEmpty && state.isLoading) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (state.images.isEmpty && state.hasError) {
                return const SliverFillRemaining(
                  child: Center(child: Text('Error loading images')),
                );
              } else {
                return state.viewType == ViewType.grid
                    ? SliverPadding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 10, right: 10),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final image = state.images[index];
                              return GestureDetector(
                                key: Key(image.id.toString()),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ImageDetailScreen(image: image),
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: 'image_${image.url}',
                                  child: gridItemContainer(image),
                                ),
                              );
                            },
                            childCount: state.images.length,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1,
                          ),
                        ),
                      )
                    : SliverList.separated(
                        itemCount: state.images.length,
                        itemBuilder: (context, index) {
                          final image = state.images[index];
                          return GestureDetector(
                            key: Key(image.id.toString()),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ImageDetailScreen(image: image),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'image_${image.url}',
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: listItemContainer(image)),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 20,
                          );
                        },
                      );
              }
            },
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text('Test Widget'),
            ),
          ),
          BlocBuilder<ImageProviderBloc, ImageProviderState>(
              builder: (context, state) {
            return SliverToBoxAdapter(
              child: state.isLoading
                  ? Container(
                      height: 100, // Ensure visibility
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: LottieBuilder.asset(
                        'assets/lottie/loader.json',
                        height: 50,
                        width: 200,
                        fit: BoxFit.fill,
                        animate: true,
                        alignment: Alignment.center,
                      ),
                    )
                  : Container(
                      height: 100, // Ensure visibility
                    ),
            );
          }),
        ],
      ),
    );
  }

  Image gridItemContainer(ImageData image) {
    return Image.network(
      image.src.tiny,
      fit: BoxFit.cover,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),
            clipBehavior: Clip.antiAlias,
            child: child);
      },
    );
  }

  Row listItemContainer(ImageData image) {
    return Row(
      children: [
        Image.network(
          image.src.tiny,
          width: 130,
          height: 80,
          fit: BoxFit.fill,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    const Center(child: CircularProgressIndicator()),
                    child,
                  ],
                ));
          },
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Photographer: ${image.photographer}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
