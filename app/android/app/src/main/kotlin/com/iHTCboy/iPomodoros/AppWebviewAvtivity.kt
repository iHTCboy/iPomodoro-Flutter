package com.iHTCboy.iPomodoros

import android.os.Bundle
import android.view.View
import android.webkit.WebView
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat

class AppWebviewAvtivity : AppCompatActivity() {
    private var myWebView: WebView? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        WindowCompat.setDecorFitsSystemWindows(window, false)
        val fileUrl = intent.getStringExtra("fileUrl") as String
        setContentView(R.layout.webview_layout)
        val root = findViewById<View>(R.id.webview_root)
        ViewCompat.setOnApplyWindowInsetsListener(root) { view, insets ->
            val bars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            view.setPadding(bars.left, bars.top, bars.right, bars.bottom)
            insets
        }
        myWebView = findViewById(R.id.webView)
        myWebView!!.loadUrl(fileUrl)
    }
}
