//-----------------------------------------------------------------------------
//           Name: gl2Renderer.h
//         Author: Kevin Harris
//  Last Modified: 04/15/12
//    Description:
//-----------------------------------------------------------------------------

#include <jni.h>
#include <android/log.h>

#include <GLES2/gl2.h>
#include <GLES2/gl2ext.h>

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

#include "matrix4x4f.h"
#include "vector3f.h"

#define LOG_TAG "libgl2renderer"
#define LOGI(...)  __android_log_print(ANDROID_LOG_INFO,LOG_TAG,__VA_ARGS__)
#define LOGE(...)  __android_log_print(ANDROID_LOG_ERROR,LOG_TAG,__VA_ARGS__)

static void printGLString( const char *name, GLenum s )
{
	const char *v = (const char *) glGetString( s );
	LOGI( "GL %s = %s\n", name, v );
}

static double getCurrentTimeInSeconds()
{
   timespec lTimeVal;
   clock_gettime( CLOCK_MONOTONIC, &lTimeVal );
   return lTimeVal.tv_sec + (lTimeVal.tv_nsec * 1.0e-9);
}

double nowTime, prevTime;

static void checkGlError( const char* op )
{
	for( GLint error = glGetError(); error; error = glGetError() )
	{
		LOGI( "after %s() glError (0x%x)\n", op, error );
	}
}

static const char gVertexShader[] =
	"attribute vec4 vPosition;\n"
	"uniform mat4 u_mvpMatrix;\n"

	"void main()\n"
    "{\n"
//	"    gl_Position = vPosition;\n"
	"    gl_Position = u_mvpMatrix * vPosition;"
	"}\n";

static const char gFragmentShader[] =
	"precision mediump float;\n"

	"void main()\n"
	"{\n"
	"     gl_FragColor = vec4( 1.0, 0.0, 0.0, 1.0 );\n"
	"}\n";

GLuint loadShader( GLenum shaderType, const char* pSource )
{
	GLuint shader = glCreateShader( shaderType );

	if( shader )
	{
		glShaderSource( shader, 1, &pSource, NULL );
		glCompileShader( shader );

		GLint compiled = 0;
		glGetShaderiv( shader, GL_COMPILE_STATUS, &compiled );

		if( !compiled )
		{
			GLint infoLen = 0;
			glGetShaderiv( shader, GL_INFO_LOG_LENGTH, &infoLen );

			if( infoLen )
			{
				char* buf = (char*) malloc( infoLen );

				if( buf )
				{
					glGetShaderInfoLog( shader, infoLen, NULL, buf );
					LOGE( "Could not compile shader %d:\n%s\n", shaderType, buf );
					free( buf );
				}

				glDeleteShader( shader );
				shader = 0;
			}
		}
	}

	return shader;
}

GLuint createProgram( const char* pVertexSource, const char* pFragmentSource )
{
	GLuint vertexShader = loadShader( GL_VERTEX_SHADER, pVertexSource );

	if( !vertexShader )
		return 0;

	GLuint pixelShader = loadShader( GL_FRAGMENT_SHADER, pFragmentSource );

	if( !pixelShader )
		return 0;

	GLuint program = glCreateProgram();

	if( program )
	{
		glAttachShader( program, vertexShader );
		checkGlError( "glAttachShader" );

		glAttachShader( program, pixelShader );
		checkGlError( "glAttachShader" );

		glLinkProgram( program );
		GLint linkStatus = GL_FALSE;
		glGetProgramiv( program, GL_LINK_STATUS, &linkStatus );

		if( linkStatus != GL_TRUE )
		{
			GLint bufLength = 0;
			glGetProgramiv( program, GL_INFO_LOG_LENGTH, &bufLength );

			if( bufLength )
			{
				char* buf = (char*) malloc( bufLength );

				if( buf )
				{
					glGetProgramInfoLog( program, bufLength, NULL, buf );
					LOGE( "Could not link program:\n%s\n", buf );
					free( buf );
				}
			}

			glDeleteProgram( program );
			program = 0;
		}
	}

	return program;
}

GLuint gProgram;
GLuint gvPositionHandle;
GLuint gmvpMatrixHandle;

bool setupGraphics( int w, int h )
{
	LOGI( "setupGraphics(%d, %d)", w, h );

	printGLString( "Version", GL_VERSION );
	printGLString( "Vendor", GL_VENDOR );
	printGLString( "Renderer", GL_RENDERER );
	printGLString( "Extensions", GL_EXTENSIONS );

	gProgram = createProgram( gVertexShader, gFragmentShader );

	if( !gProgram )
	{
		LOGE( "Could not create program." );
		return false;
	}

	gvPositionHandle = glGetAttribLocation( gProgram, "vPosition" );
	checkGlError( "glGetAttribLocation" );
	LOGI( "glGetAttribLocation(\"vPosition\") = %d\n", gvPositionHandle );

	gmvpMatrixHandle = glGetUniformLocation ( gProgram, "u_mvpMatrix" );
	checkGlError( "glGetUniformLocation" );
	LOGI( "glGetUniformLocation(\"u_mvpMatrix\") = %d\n", gmvpMatrixHandle );

	glViewport( 0, 0, w, h );
	checkGlError( "glViewport" );

	nowTime = getCurrentTimeInSeconds();
	prevTime = nowTime;

	return true;
}

const GLfloat gTriangleVertices[] =
{
	 0.0f,  0.5f, 0.0f,
	-0.5f, -0.5f, 0.0f,
	 0.5f, -0.5f, 0.0f
};

struct MyVertex
{
  float x, y, z;        //Vertex
  float nx, ny, nz;     //Normal
  float s0, t0;         //Texcoord0
};



void renderFrame()
{
	nowTime = getCurrentTimeInSeconds();
	double elapsed = nowTime - prevTime;

	static float grey = 1.0f;
	//grey += 0.01f;

	if( grey > 1.0f )
		grey = 0.0f;

	glClearColor( grey, grey, grey, 1.0f );
	checkGlError( "glClearColor" );
	glClear( GL_DEPTH_BUFFER_BIT | GL_COLOR_BUFFER_BIT );
	checkGlError( "glClear" );

	glUseProgram( gProgram );
	checkGlError( "glUseProgram" );




	MyVertex pvertex[3];
	//VERTEX 0
	pvertex[0].x = 0.0f;
	pvertex[0].y = 0.5f;
	pvertex[0].z = 0.0f;
	pvertex[0].nx = 0.0f;
	pvertex[0].ny = 0.0f;
	pvertex[0].nz = 1.0f;
	pvertex[0].s0 = 0.0f;
	pvertex[0].t0 = 0.0f;
	//VERTEX 1
	pvertex[1].x = -0.5f;
	pvertex[1].y = 0.0f;
	pvertex[1].z = -0.5f;
	pvertex[1].nx = 0.0f;
	pvertex[1].ny = 0.0f;
	pvertex[1].nz = 1.0f;
	pvertex[1].s0 = 1.0f;
	pvertex[1].t0 = 0.0f;
	//VERTEX 2
	pvertex[2].x = 0.5f;
	pvertex[2].y = -0.5f;
	pvertex[2].z = 0.0f;
	pvertex[2].nx = 0.0f;
	pvertex[2].ny = 0.0f;
	pvertex[2].nz = 1.0f;
	pvertex[2].s0 = 0.0f;
	pvertex[2].t0 = 1.0f;



	/*
	float mvp[16] =
	{
		1.0f, 0.0f, 0.0f, 0.0f,
		0.0f, 1.0f, 0.0f, 0.0f,
		0.0f, 0.0f, 1.0f, 0.0f,
		0.0f, 0.0f, 0.0f, 1.0f
	};

	glUniformMatrix4fv( gmvpMatrixHandle, 1, GL_FALSE, (GLfloat*) &mvp[0] );
	*/

	static float rotationY = 0.0f;
	rotationY += (elapsed * 50.0f);

	if( rotationY > 360.0f )
		rotationY = 0.0f;

	matrix4x4f mvp;
	mvp.rotate_y( rotationY );

	glUniformMatrix4fv( gmvpMatrixHandle, 1, GL_FALSE, mvp.m );
	checkGlError( "glUniformMatrix4fv" );
/*
	 //Define this somewhere in your header file
#define BUFFER_OFFSET(i) ((char *)NULL + (i))

	  //glEnableVertexAttribArray(0);    //We like submitting vertices on stream 0 for no special reason
	  glVertexAttribPointer(gvPositionHandle, 3, GL_FLOAT, GL_FALSE, sizeof(MyVertex), BUFFER_OFFSET(0));   //The starting point of the VBO, for the vertices
	  //glEnableVertexAttribArray(1);    //We like submitting normals on stream 1 for no special reason
	  //glVertexAttribPointer(gvPositionHandle, 3, GL_FLOAT, GL_FALSE, sizeof(MyVertex), BUFFER_OFFSET(12));     //The starting point of normals, 12 bytes away
	  //glEnableVertexAttribArray(2);    //We like submitting texcoords on stream 2 for no special reason
	 // glVertexAttribPointer(gvPositionHandle, 2, GL_FLOAT, GL_FALSE, sizeof(MyVertex), BUFFER_OFFSET(24));   //The starting point of texcoords, 24 bytes away
//*/

	glVertexAttribPointer( gvPositionHandle, 3, GL_FLOAT, GL_FALSE, 0, gTriangleVertices );
	checkGlError( "glVertexAttribPointer" );

	glEnableVertexAttribArray( gvPositionHandle );
	checkGlError( "glEnableVertexAttribArray" );

	glDrawArrays( GL_TRIANGLES, 0, 3 );
	checkGlError( "glDrawArrays" );

	prevTime = nowTime;
}

extern "C"
{
JNIEXPORT void JNICALL Java_edu_smu_guildhall_nativegl2_GL2RendererLib_init(JNIEnv * env, jobject obj, jint width, jint height);
JNIEXPORT void JNICALL Java_edu_smu_guildhall_nativegl2_GL2RendererLib_step(JNIEnv * env, jobject obj);
};

JNIEXPORT void JNICALL Java_edu_smu_guildhall_nativegl2_GL2RendererLib_init(JNIEnv * env, jobject obj, jint width, jint height)
{
	setupGraphics(width, height);
}

JNIEXPORT void JNICALL Java_edu_smu_guildhall_nativegl2_GL2RendererLib_step(JNIEnv * env, jobject obj)
{
	renderFrame();
}
