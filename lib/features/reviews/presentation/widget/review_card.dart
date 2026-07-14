import 'package:flutter/material.dart';

class WriteReviewCard extends StatefulWidget {
  final Function(double rating, String comment) onSubmit;

  const WriteReviewCard({super.key, required this.onSubmit});

  @override
  State<WriteReviewCard> createState() => _WriteReviewCardState();
}

class _WriteReviewCardState extends State<WriteReviewCard> {
  final TextEditingController _controller = TextEditingController();

  double rating = 5;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Write a Review",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          Row(
            children: List.generate(
              5,
              (index) => IconButton(
                onPressed: () {
                  setState(() {
                    rating = index + 1.0;
                  });
                },
                icon: Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: _controller,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: "Share your experience...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onSubmit(rating, _controller.text.trim());
              },
              child: const Text("Submit Review"),
            ),
          ),
        ],
      ),
    );
  }
}
