package org.sample.plant_watering

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
}


interface ComponentDefinition {
    var name : String
    var packageName: String
    fun toClassName():String? {
        return "$packageName.$name"
    }
}
