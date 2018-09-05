import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '00_base_page.dart';

class GridViewPage extends BasePage {
  GridViewPage({Key key, String title}) : super(key: key, title: title);

  @override
  _GridViewPageState createState() => _GridViewPageState();
}

typedef OnSelectGridTitleStyle(GridTitleStyle style);

class _GridViewPageState extends BasePageState<GridViewPage> {
  @override
  List<Widget> get actions {
    final actions = <Widget>[
      IconButton(
        icon: Icon(Icons.adjust, color: _isComplexGrid ? Colors.white : Colors.red),
        onPressed: () => setState(() => _isComplexGrid = !_isComplexGrid),
      ),
    ];

    if (_isComplexGrid) {
      actions.insertAll(
        0,
        <Widget>[
          PopupMenuButton<GridTitleStyle>(
            onSelected: (value) => setState(() => _titleStyle = value),
            itemBuilder: (context) => <PopupMenuItem<GridTitleStyle>>[
              PopupMenuItem<GridTitleStyle>(
                value: GridTitleStyle.imageOnly,
                child: Text('Image only'),
              ),
              PopupMenuItem<GridTitleStyle>(
                value: GridTitleStyle.oneLine,
                child: Text('One line'),
              ),
              PopupMenuItem<GridTitleStyle>(
                value: GridTitleStyle.twoLine,
                child: Text('Two line'),
              )
            ],
          ),
        ],
      );
    }

    return actions;
  }

  bool _isComplexGrid = true;
  GridTitleStyle _titleStyle = GridTitleStyle.twoLine;

  @override
  Widget buildBody(BuildContext content) {
    return _isComplexGrid ? _ComplexGrid(titleStyle: _titleStyle) : _SimpleGrid();
  }
}

// =============================================================================

class _SimpleGrid extends StatelessWidget {
  List<Image> _buildGridImageList(int count) {
    return List.generate(
        count, (index) => Image.asset('images/pic${index + 1}.jpg'));
  }

  Widget _buildGridWithExtent(BuildContext context) {
    return GridView.extent(
      padding: const EdgeInsets.all(4.0),
      maxCrossAxisExtent: 150.0,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      children: _buildGridImageList(30),
    );
  }

  Widget _buildGridWithCount(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(4.0),
      crossAxisCount:
          MediaQuery.of(context).orientation == Orientation.portrait ? 3 : 5,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      children: _buildGridTileList(30),
    );
  }

  List<Image> _buildGridTileList(int count) {
    return List.generate(
        count, (index) => Image.asset('images/pic${index + 1}.jpg'));
  }

  @override
  Widget build(BuildContext context) {
    return _buildGridWithExtent(context);
  }
}

// =============================================================================

class _ComplexGrid extends StatefulWidget {
  const _ComplexGrid({GridTitleStyle titleStyle}) : _titleStyle = titleStyle;

  final GridTitleStyle _titleStyle;

  @override
  _ComplexGridState createState() => _ComplexGridState();
}

class _ComplexGridState extends State<_ComplexGrid> {
  final List<Photo> _photos = <Photo>[
    Photo(
      assetName: 'places/india_chennai_flower_market.png',
      assetPackage: _galleryAssetsPackage,
      title: 'Chennai',
      caption: 'Flower Market',
    ),
    Photo(
      assetName: 'places/india_tanjore_bronze_works.png',
      assetPackage: _galleryAssetsPackage,
      title: 'Tanjore',
      caption: 'Bronze Works',
    ),
    Photo(
      assetName: 'places/india_tanjore_market_merchant.png',
      assetPackage: _galleryAssetsPackage,
      title: 'Tanjore',
      caption: 'Market',
    ),
    Photo(
      assetName: 'places/india_tanjore_thanjavur_temple.png',
      assetPackage: _galleryAssetsPackage,
      title: 'Tanjore',
      caption: 'Thanjavur Temple',
    ),
    Photo(
      assetName: 'places/india_tanjore_thanjavur_temple_carvings.png',
      assetPackage: _galleryAssetsPackage,
      title: 'Tanjore',
      caption: 'Thanjavur Temple',
    ),
    Photo(
      assetName: 'places/india_pondicherry_salt_farm.png',
      assetPackage: _galleryAssetsPackage,
      title: 'Pondicherry',
      caption: 'Salt Farm',
    ),
    Photo(
      assetName: 'places/india_chennai_highway.png',
      assetPackage: _galleryAssetsPackage,
      title: 'Chennai',
      caption: 'Scooters',
    ),
    Photo(
      assetName: 'places/india_chettinad_silk_maker.png',
      assetPackage: _galleryAssetsPackage,
      title: 'Chettinad',
      caption: 'Silk Maker',
    ),
    Photo(
      assetName: 'places/india_chettinad_produce.png',
      assetPackage: _galleryAssetsPackage,
      title: 'Chettinad',
      caption: 'Lunch Prep',
    ),
    Photo(
      assetName: 'places/india_tanjore_market_technology.png',
      assetPackage: _galleryAssetsPackage,
      title: 'Tanjore',
      caption: 'Market',
    ),
    Photo(
      assetName: 'places/india_pondicherry_beach.png',
      assetPackage: _galleryAssetsPackage,
      title: 'Pondicherry',
      caption: 'Beach',
    ),
    Photo(
      assetName: 'places/india_pondicherry_fisherman.png',
      assetPackage: _galleryAssetsPackage,
      title: 'Pondicherry',
      caption: 'Fisherman',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Column(
      children: <Widget>[
        Expanded(
          child: SafeArea(
            left: false,
            top: false,
            right: false,
            bottom: false,
            child: GridView.count(
              crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(4.0),
              childAspectRatio:
                  (orientation == Orientation.portrait) ? 1.0 : 1.3,
              children: _photos.map((photo) {
                return GridPhotoItem(
                  photo: photo,
                  titleStyle: widget._titleStyle,
                  onBannerTap: (photo) {
                    setState(() => photo.isFavorite = !photo.isFavorite);
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

enum GridTitleStyle { imageOnly, oneLine, twoLine }

typedef void BannerTapCallback(Photo photo);

const double _minFlingVelocity = 800.0;
const String _galleryAssetsPackage = 'flutter_gallery_assets';

class _GridTitleText extends StatelessWidget {
  final String text;

  const _GridTitleText(this.text);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Text(text),
    );
  }
}

class GridPhotoItem extends StatelessWidget {
  final Photo photo;
  final GridTitleStyle titleStyle;
  final BannerTapCallback onBannerTap;

  GridPhotoItem({
    Key key,
    @required this.photo,
    @required this.titleStyle,
    @required this.onBannerTap})
      : assert(photo != null && photo.isValid),
        assert(titleStyle != null),
        assert(onBannerTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = GestureDetector(
      onTap: () => _showPhoto(context),
      child: Hero(
        key: Key(photo.assetName),
        tag: photo.tag,
        child: Image.asset(
          photo.assetName,
          package: photo.assetPackage,
          fit: BoxFit.cover,
        ),
      ),
    );

    if (titleStyle == GridTitleStyle.imageOnly) {
      return image;
    }

    return GridTile(
      footer: GestureDetector(
        onTap: () => onBannerTap(photo),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                child: Container(
                  color: Colors.black45,
                ),
              ),
            ),
            GridTileBar(
              title: _GridTitleText(photo.title),
              subtitle: titleStyle == GridTitleStyle.twoLine
                  ? _GridTitleText(photo.caption) : null,
//              backgroundColor: Colors.black45,
              trailing: Icon(
                photo.isFavorite ? Icons.star : Icons.star_border,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      child: image,
    );
  }

  void _showPhoto(BuildContext context) {
    Navigator.push(context, MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(title: Text(photo.title)),
          body: SizedBox.expand(
            child: Hero(
              tag: photo.tag,
              child: GridPhotoViewer(photo: photo),
            ),
          ),
        );
      },
    ));
  }
}

class Photo {
  Photo({
    @required this.assetName,
    this.assetPackage,
    @required this.title,
    @required this.caption,
    this.isFavorite = false,
  });

  final String assetName;
  final String assetPackage;
  final String title;
  final String caption;

  bool isFavorite;
  String get tag => assetName;
  bool get isValid =>
      assetName != null &&
          title != null &&
          caption != null;
}

// =============================================================================

class GridPhotoViewer extends StatefulWidget {
  GridPhotoViewer({Key key, this.photo}) : super(key: key);

  final Photo photo;

  @override
  _GridPhotoViewerState createState() => _GridPhotoViewerState();
}

class _GridPhotoViewerState extends State<GridPhotoViewer>
    with SingleTickerProviderStateMixin { // ignore: mixin_inherits_from_not_object
  AnimationController _controller;
  Animation<Offset> _flingAnimation;
  Offset _offset = Offset.zero;
  double _scale = 1.0;
  Offset _normalizedOffset;
  double _previousScale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this)
      ..addListener(_handleFlingAnimation);
  }

  @override
  void dpose() {
    _controller.dispose();
    super.dispose();
  }

  // The maximum offset value is 0,0. If the size of this renderer's box is w,h
  // then the minimum offset value is w - _scale * w, h - _scale * h.
  Offset _clampOffset(Offset offset) {
    final Size size = context.size;
    final Offset minOffset = Offset(size.width, size.height) * (1.0 - _scale);
    return Offset(
        offset.dx.clamp(minOffset.dx, 0.0), offset.dy.clamp(minOffset.dy, 0.0));
  }

  void _handleFlingAnimation() {
    setState(() {
      _offset = _flingAnimation.value;
    });
  }

  void _handleOnScaleStart(ScaleStartDetails details) {
    setState(() {
      _previousScale = _scale;
      _normalizedOffset = (details.focalPoint - _offset) / _scale;
//      print('scale: $_scale, normalizedOffset: $_normalizedOffset');
      // The fling animation stops if an input gesture starts.
      _controller.stop();
    });
  }

  void _handleOnScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _scale = (_previousScale * details.scale).clamp(1.0, 4.0);
      // Ensure that image location under the focal point stays in the same place despite scaling.
      _offset = _clampOffset(details.focalPoint - _normalizedOffset * _scale);
    });
  }

  void _handleOnScaleEnd(ScaleEndDetails details) {
    final magnitude = details.velocity.pixelsPerSecond.distance;
    if (magnitude < _minFlingVelocity) return;
    final direction = details.velocity.pixelsPerSecond / magnitude;
    final distance = (Offset.zero & context.size).shortestSide;
    _flingAnimation = Tween<Offset>(
            begin: _offset, end: _clampOffset(_offset + direction * distance))
        .animate(_controller);
    _controller
      ..value = 0.0
      ..fling(velocity: magnitude / 1000.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: _handleOnScaleStart,
      onScaleUpdate: _handleOnScaleUpdate,
      onScaleEnd: _handleOnScaleEnd,
      child: ClipRect(
        child: Transform(
          transform: Matrix4.identity()
            ..translate(_offset.dx, _offset.dy)
            ..scale(_scale),
          child: Image.asset(
            widget.photo.assetName,
            package: widget.photo.assetPackage,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}