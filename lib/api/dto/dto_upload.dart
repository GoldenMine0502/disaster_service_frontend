

class ResponseDisasterDetection {
  final List<double> output;
  final int label;

  ResponseDisasterDetection({
    required this.output,
    required this.label,
  });

  // Factory method to create an instance from a JSON object
  factory ResponseDisasterDetection.fromJson(Map<String, dynamic> json) {
    return ResponseDisasterDetection(
      output: List<double>.from(json['output']),
      label: json['label'],
    );
  }

  // Method to calculate labelPercent, equivalent to the Kotlin method
  double labelPercent() {
    return output[label];
  }
}