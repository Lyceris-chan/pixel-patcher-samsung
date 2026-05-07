package com.pixelbridge.complications

object ComplicationValueSanitizer {
    private val sleepPattern = Regex("(\d+)h(?:\s*(\d+)m)?")

    fun sanitize(raw: Float, min: Float, max: Float): Float {
        if (!min.isFinite() || !max.isFinite() || max <= min) return min
        val epsilon = 0.001f
        val lower = min + epsilon
        val upper = max - epsilon
        if (lower >= upper) return min
        val candidate = if (raw.isFinite()) raw else lower
        return candidate.coerceIn(lower, upper)
    }

    fun parseNumeric(raw: String): Float {
        val normalized = raw.replace(Regex("[^0-9.-]"), "")
        return normalized.toFloatOrNull() ?: 0f
    }

    fun parseSleepHours(raw: String): Float {
        val match = sleepPattern.find(raw)
        if (match != null) {
            val hours = match.groupValues[1].toFloatOrNull() ?: 0f
            val minutes = match.groupValues.getOrNull(2)?.toFloatOrNull() ?: 0f
            return hours + (minutes / 60f)
        }
        return parseNumeric(raw)
    }
}
