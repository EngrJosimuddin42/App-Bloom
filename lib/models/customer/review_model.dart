class ReviewModel {
  final String reviewerName;
  final String reviewerImage;
  final double rating;
  final String comment;
  final String timeAgo;

  const ReviewModel({
    required this.reviewerName,
    this.reviewerImage = '',
    required this.rating,
    this.comment = '',
    required this.timeAgo,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      reviewerName: json['reviewer_name'] ?? '',
      reviewerImage: json['reviewer_image'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      comment: json['comment'] ?? '',
      timeAgo: json['time_ago'] ?? '',
    );
  }
}