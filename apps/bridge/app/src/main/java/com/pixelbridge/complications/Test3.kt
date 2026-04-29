package test
import androidx.health.services.client.data.DataType
import androidx.health.services.client.data.DeltaDataType
import androidx.health.services.client.data.AggregateDataType
class Test3 {
    fun test() {
        val a: DeltaDataType<*, *> = DataType.HEART_RATE_BPM
        val b: DeltaDataType<*, *> = DataType.STEPS
        val c: DeltaDataType<*, *> = DataType.DISTANCE
        val d: DeltaDataType<*, *> = DataType.FLOORS
        val e: AggregateDataType<*, *> = DataType.CALORIES_TOTAL
    }
}
