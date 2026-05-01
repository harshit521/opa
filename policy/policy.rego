package cicd

deny[msg] {
    input.course_price < 0
    msg := "Course price cannot be negative"
}

deny[msg] {
    input.isPublished == true
    input.content_missing == true
    msg := "Published course must have content"
}

deny[msg] {
    input.env != "prod"
    msg := "Deployment allowed only in production"
}