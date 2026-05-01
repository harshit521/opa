package auth

default allow = false

# =========================
# INSTRUCTOR
# =========================

allow if {
    input.role == "instructor"
    input.action == "create"
}

allow if {
    input.role == "instructor"
    input.action == "update"
    input.course_owner == input.user
}

allow if {
    input.role == "instructor"
    input.action == "delete"
    input.course_owner == input.user
    not input.isPublished
}

# =========================
# STUDENT
# =========================

allow if {
    input.role == "student"
    input.action == "view"
    input.enrolled == true
}

# =========================
# GUEST
# =========================

allow if {
    input.role == "guest"
    input.action == "view"
    input.isFree == true
}

# =========================
# GLOBAL DENY RULE
# =========================

deny contains msg if {
    input.action == "delete"
    input.isPublished == true
    msg := "Cannot delete a published course"
}