import 'package:card_loading/card_loading.dart';
import 'package:cdc/app/modules/home/controllers/post_item_controller.dart';
import 'package:cdc/app/modules/home/views/detail_post_item_view.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:transparent_image/transparent_image.dart';

class PostItemView extends StatefulWidget {
  const PostItemView({super.key});

  @override
  State<PostItemView> createState() => _PostItemViewState();
}

class _PostItemViewState extends State<PostItemView> {
  final controller = Get.put(PostItemController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    update();
  }

  void update() async {
    await controller.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadPost(context);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          if (controller.postList.isEmpty) {
            return const SizedBox();
          }
          return buildPostListView();
        }
      },
    );
  }

  Widget buildPostListView() {
    return Obx(
      () => Column(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.postList.length,
            itemBuilder: (context, index) {
              final post = controller.postList[index];

              String dateTime = controller.postList[index].postAt;
              final date = DateTime.parse(dateTime);
              initializeDateFormatting('id_ID', null);
              final dateFormat = DateFormat('dd MMMM yyyy', 'id_ID');
              final timeFormat = DateFormat('HH:mm');
              final formattedDate = dateFormat.format(date);
              final formattedTime = timeFormat.format(date);

              return GestureDetector(
                onTap: () {
                  Get.to(() => DetailPostItemView(
                        id: post.id,
                        isUser: false,
                      ));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(post
                                          .uploader.foto ==
                                      ApiServices.baseUrlImage
                                  ? "https://th.bing.com/th/id/OIP.dcLFW3GT9AKU4wXacZ_iYAHaGe?pid=ImgDet&rs=1"
                                  : post.uploader.foto ?? ""),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post.uploader.fullname ?? "",
                                  style: AppFonts.poppins(
                                      fontSize: 12,
                                      color: black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '$formattedDate, $formattedTime',
                                  style: AppFonts.poppins(
                                      fontSize: 11, color: black),
                                )
                              ],
                            )),
                            InkWell(
                              onTap: () {
                                show(
                                    post.position,
                                    post.company,
                                    post.typeJobs,
                                    post.description,
                                    post.expired,
                                    post.linkApply);
                              },
                              child: Icon(
                                Icons.info_outline,
                                color: black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: post.image,
                            fit: BoxFit.cover,
                            height: 500,
                            width: double.infinity,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            "images/comment.png",
                            height: 30,
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              right: 10, left: 10, top: 10),
                          child: ReadMoreText(
                            post.description,
                            trimLines: 2,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: "Baca Selengkapnya",
                            trimExpandedText: "...Lebih Sedikit",
                            lessStyle: AppFonts.poppins(
                                fontSize: 12,
                                color: black,
                                fontWeight: FontWeight.bold),
                            moreStyle: AppFonts.poppins(
                                fontSize: 12,
                                color: black,
                                fontWeight: FontWeight.bold),
                            style: AppFonts.poppins(fontSize: 12, color: black),
                          ))
                    ],
                  ),
                ),
              );
            },
          ),
          if (controller.hasMore == true)
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                  child: CircularProgressIndicator(
                color: black,
              )),
            ),
        ],
      ),
    );
  }

  Widget loadPost(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    CardLoading(
                      height: 50,
                      width: 50,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CardLoading(
                          height: 8,
                          width: 100,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CardLoading(
                          height: 8,
                          width: 150,
                        ),
                      ],
                    )),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: CardLoading(
                  height: 500,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: CardLoading(
                      height: 30,
                      width: 30,
                      borderRadius: BorderRadius.circular(100),
                    )),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 10, left: 10, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CardLoading(
                      height: 8,
                      width: double.infinity,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CardLoading(
                      height: 8,
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void show(String position, String company, String typeJobs,
      String description, String expired, String link) {
    Get.dialog(AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            position,
            style: AppFonts.poppins(
                fontSize: 14, color: black, fontWeight: FontWeight.bold),
          ),
          Text(
            company,
            style: AppFonts.poppins(
                fontSize: 12, color: black, fontWeight: FontWeight.normal),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Jenis Pekerjaan",
                        style: AppFonts.poppins(fontSize: 12, color: black),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: white),
                        child: Text(
                          typeJobs,
                          style: AppFonts.poppins(fontSize: 12, color: black),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (link.isNotEmpty) {
                      controller.launchURL(link);
                    } else {
                      print(null);
                    }
                  },
                  child: Container(
                    color: white,
                    child: Row(
                      children: [
                        Image.asset(
                          'images/link.png',
                          height: 15,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Kunjungi",
                          style: AppFonts.poppins(fontSize: 12, color: black),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Text(
              "Deskripsi",
              style: AppFonts.poppins(fontSize: 12, color: black),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: white),
              child: Text(
                description,
                style: AppFonts.poppins(fontSize: 12, color: black),
              ),
            ),
            Text(
              "Ditutup",
              style: AppFonts.poppins(fontSize: 12, color: black),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: white),
              child: Text(
                expired,
                style: AppFonts.poppins(fontSize: 12, color: black),
              ),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            10.0), // Sesuaikan dengan radius yang Anda inginkan
      ),
    ));
  }
}
