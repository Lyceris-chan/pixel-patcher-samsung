package com.pixelbridge.complications

import android.content.Context
import androidx.health.services.client.data.DataType
import androidx.wear.protolayout.DeviceParametersBuilders
import androidx.wear.protolayout.DimensionBuilders.expand
import androidx.wear.protolayout.LayoutElementBuilders
import androidx.wear.protolayout.ResourceBuilders
import androidx.wear.protolayout.expression.DynamicBuilders
import androidx.wear.protolayout.expression.PlatformEventSources
import androidx.wear.protolayout.material3.CardDefaults
import androidx.wear.protolayout.material3.CircularProgressIndicatorDefaults
import androidx.wear.protolayout.material3.GraphicDataCardDefaults
import androidx.wear.protolayout.material3.PrimaryLayoutMargins
import androidx.wear.protolayout.material3.Typography
import androidx.wear.protolayout.material3.circularProgressIndicator
import androidx.wear.protolayout.material3.graphicDataCard
import androidx.wear.protolayout.material3.icon
import androidx.wear.protolayout.material3.materialScope
import androidx.wear.protolayout.material3.primaryLayout
import androidx.wear.protolayout.material3.text
import androidx.wear.protolayout.material3.textEdgeButton
import androidx.wear.protolayout.modifiers.clickable
import androidx.wear.protolayout.types.layoutString
import androidx.wear.tiles.RequestBuilders
import java.text.NumberFormat

abstract class MetricGoalTileService : BaseHealthTileService() {
    protected val healthDataManager by lazy { HealthDataManager(applicationContext) }

    abstract val label: String
    abstract val goal: Int
    abstract val iconRes: Int
    abstract fun metricValue(): Int

    override fun layout(context: Context, deviceParameters: DeviceParametersBuilders.DeviceParameters): LayoutElementBuilders.LayoutElement {
        val value = metricValue().coerceAtLeast(0)
        val safeGoal = goal.coerceAtLeast(1)
        val progress = (value.toFloat() / safeGoal).coerceIn(0f, 1f)
        val valueStr = NumberFormat.getNumberInstance().format(value)
        val goalStr = NumberFormat.getNumberInstance().format(safeGoal)

        return materialScope(context = context, deviceConfiguration = deviceParameters) {
            primaryLayout(
                titleSlot = { text(label.layoutString) },
                margins = PrimaryLayoutMargins.MIN_PRIMARY_LAYOUT_MARGIN,
                mainSlot = {
                    graphicDataCard(
                        onClick = clickable(),
                        height = expand(),
                        colors = CardDefaults.filledTonalCardColors(),
                        title = { text(valueStr.layoutString, typography = Typography.DISPLAY_SMALL) },
                        content = { text("of $goalStr".layoutString, typography = Typography.TITLE_SMALL) },
                        horizontalAlignment = LayoutElementBuilders.HORIZONTAL_ALIGN_END,
                        graphic = {
                            GraphicDataCardDefaults.constructGraphic(
                                mainContent = {
                                    circularProgressIndicator(
                                        staticProgress = progress,
                                        dynamicProgress = DynamicBuilders.DynamicFloat.onCondition(
                                            PlatformEventSources.isLayoutVisible()
                                        ).use(progress).elseUse(0f)
                                            .animate(CircularProgressIndicatorDefaults.recommendedAnimationSpec),
                                        startAngleDegrees = 200f,
                                        endAngleDegrees = 520f
                                    )
                                },
                                iconContent = { icon("android.resource://$packageName/$iconRes") }
                            )
                        }
                    )
                },
                bottomSlot = { textEdgeButton(onClick = clickable()) { text("Open".layoutString) } }
            )
        }
    }

    override fun resources(context: Context): (RequestBuilders.ResourcesRequest) -> ResourceBuilders.Resources = {
        ResourceBuilders.Resources.Builder().setVersion(TILE_RES_VERSION).build()
    }
}

class StepsGoalTileService : MetricGoalTileService() {
    override val label = "Steps"
    override val goal = 10000
    override val iconRes = R.drawable.ic_steps
    override fun metricValue(): Int = ComplicationValueSanitizer.parseNumeric(healthDataManager.getLatestData(DataType.STEPS)).toInt()
}

class HeartRateGoalTileService : MetricGoalTileService() {
    override val label = "Heart Rate"
    override val goal = 220
    override val iconRes = R.drawable.ic_heart
    override fun metricValue(): Int = ComplicationValueSanitizer.parseNumeric(healthDataManager.getLatestData(DataType.HEART_RATE_BPM)).toInt()
}

class CaloriesGoalTileService : MetricGoalTileService() {
    override val label = "Calories"
    override val goal = 3000
    override val iconRes = R.drawable.ic_generic_health
    override fun metricValue(): Int = ComplicationValueSanitizer.parseNumeric(healthDataManager.getLatestData(DataType.CALORIES_TOTAL)).toInt()
}

class DistanceGoalTileService : MetricGoalTileService() {
    override val label = "Distance"
    override val goal = 10
    override val iconRes = R.drawable.ic_generic_health
    override fun metricValue(): Int = ComplicationValueSanitizer.parseNumeric(healthDataManager.getLatestData(DataType.DISTANCE)).toInt()
}

class FloorsGoalTileService : MetricGoalTileService() {
    override val label = "Floors"
    override val goal = 50
    override val iconRes = R.drawable.ic_generic_health
    override fun metricValue(): Int = ComplicationValueSanitizer.parseNumeric(healthDataManager.getLatestData(DataType.FLOORS)).toInt()
}

class SpO2GoalTileService : MetricGoalTileService() {
    override val label = "SpO2"
    override val goal = 100
    override val iconRes = R.drawable.ic_generic_health
    override fun metricValue(): Int = ComplicationValueSanitizer.parseNumeric(healthDataManager.getLatestDataByName("SPO2")).toInt()
}

class SleepGoalTileService : MetricGoalTileService() {
    override val label = "Sleep"
    override val goal = 12
    override val iconRes = R.drawable.ic_generic_health
    override fun metricValue(): Int = ComplicationValueSanitizer.parseSleepHours(healthDataManager.getLatestDataByName("READ_SLEEP")).toInt()
}
