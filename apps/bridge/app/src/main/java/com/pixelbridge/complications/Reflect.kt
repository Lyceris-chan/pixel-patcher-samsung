package test
import androidx.health.services.client.data.DataPointContainer
class Reflect {
    fun getMethods() {
        DataPointContainer::class.java.methods.forEach { println(it.name) }
    }
}
