package edu.smu.guildhall.nativegl2;

// Wrapper for native library

public class GL2RendererLib {

     static {
         System.loadLibrary("gl2renderer");
     }

    /**
     * @param width the current view width
     * @param height the current view height
     */
     public static native void init(int width, int height);
     public static native void step();
}
