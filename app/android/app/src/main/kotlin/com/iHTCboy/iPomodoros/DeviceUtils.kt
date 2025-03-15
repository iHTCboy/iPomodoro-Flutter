package com.iHTCboy.iPomodoros
import android.os.Build
import java.lang.reflect.Method

object DeviceUtils {
    //emuiApiLevel>0 即华为系统
    //判断是否是华为系统 官网提供
    val isEMUI: Boolean
        get() {
            //emuiApiLevel>0 即华为系统
            var emuiApiLevel: Int = 0
            try {
                val cls = Class.forName("android.os.SystemProperties")
                val method: Method = cls.getDeclaredMethod("get", *arrayOf<Class<*>>(String::class.java))
                emuiApiLevel = (method.invoke(cls, arrayOf<Any>("ro.build.hw_emui_api_level")) as String).toInt()
            } catch (e: Exception) {
                e.printStackTrace()
            }
            return emuiApiLevel > 0
        }//这个字符串可以自己定义,例如判断华为就填写huawei,魅族就填写meizu

    //判官是否是小米系统 官网提供
    val isMIUI: Boolean
        get() {
            val manufacturer: String = Build.MANUFACTURER
            //这个字符串可以自己定义,例如判断华为就填写huawei,魅族就填写meizu
            if ("xiaomi".equals(manufacturer, ignoreCase = true)) {
                return true
            }
            return false
        }
}

