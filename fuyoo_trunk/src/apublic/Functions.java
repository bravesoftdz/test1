package apublic;

//���� ios �Ĺ��ú���

import android.os.Bundle;
import android.app.Activity;
import android.app.AlertDialog;
import android.view.*;
import android.widget.Button;

import java.lang.reflect.*; //���亯����Ҫ��


public class Functions 
{
	//�������������ļ���������������ķ��,������ú���,��ÿ�� Activity ��Ҫ��������
	//--------------------------------------------------
	//<!-- Application theme. -->
	//<style name="AppTheme" parent="AppBaseTheme">
	//    <!-- All customizations that are NOT specific to a particular API-level can go here. -->
	//    <!-- ����״̬�� -->
	//    <item name="android:windowFullscreen">true</item>
	//    <!-- ���ر����� -->
	//    <item name="android:windowNoTitle">true</item>
	//</style>	
	//--------------------------------------------------
	static public void SetFullScreen(Activity _this)
	{
		//��Activity��onCreate()�����е�super()��setContentView()��������֮�����
		//--------------------------------------------------

		//���ر�����
		_this.requestWindowFeature(Window.FEATURE_NO_TITLE);
		//����״̬��
		_this.getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,
						WindowManager.LayoutParams.FLAG_FULLSCREEN);
		
	}//
	
	//��ʾһ����Ϣ��
	static public void ShowMessage(String s, Activity  ct)
	{
		new AlertDialog.Builder(ct)//self)    
		.setTitle("��Ϣ")  
		.setMessage(s)  
		.setPositiveButton("ȷ��", null)  
		.show(); 
		
	}//
	
	//����һ����ť[��ʵ�� view]��  onClick �¼�,���Ծ�˵�� xml �������Դ��,��Ϊjava����ֱ�ӽ�������Ϊ��������[ֻ������],������ԭ��Ӧ����
	//������Ʒ������
	//̫����,��ʵ�Լ��õĻ�����д�ü򵥵�
	static public void SetOnClick(View _view, String funcName, Activity _activity)
	{
		//��˵���� View ���Դ��
		final String handlerName = funcName;
		final View view = _view; //������һ�� final �����͵����������������ȥ����,��ͨ�����ǲ��е�
		final Activity activity = _activity;
		
		//view.getContext().getClass().getMethod("");

    	//view.setOnClickListener(new OnClickListener() {
		//view.setOnClickListener(new Button.OnClickListener() {
        view.setOnClickListener(new View.OnClickListener() {
        	
            private Method mHandler;
  
            public void onClick(View v) 
            {
                    try 
                    {
                        //mHandler = view.getContext().getClass().getMethod(handlerName, View.class);
                        ////mHandler = activity.getClass().getMethod(handlerName, View.class);
                        mHandler = activity.getClass().getMethod(handlerName);
                        
                        //����Ǹ��ݷ�������,�Լ�������������������ȡָ���ķ���//�ô����ǲ��е�,Ҫ���ݺ���ԭ���Ĳ����б���ȡ
                    } 
                    catch (NoSuchMethodException e) //û�ҵ�������Ƶĺ����Ļ�
                    {
                    	Functions.ShowMessage(handlerName + "����������(ע���������).", activity);
                    	return;
                    	
                    	//���ǲ�Ҫ�׳��쳣�ĺ�,��ĳЩģ�����ϻ�ֱ�ӱ���
//                        throw new IllegalStateException("Could not find a method " +
//                                handlerName + "(View) in the activity "
//                                + activity.getClass() + " for onClick handler"
//                                + " on view " + activity.getClass().getName(), e);
                    }//



                    try 
                    {
                        //mHandler.invoke(getContext(), View.this);
                    	////mHandler.invoke(view.getContext(), view);
                    	mHandler.invoke(activity); //invoke �Ĳ���Ҳ����Ե���,����Ҫ�ഫ��һ�� this
                    } 
                    catch (IllegalAccessException e) 
                    {
                    	Functions.ShowMessage(handlerName + "����ִ���쳣(ע���������).", activity);
                    	return;
                    	
                    	//���ǲ�Ҫ�׳��쳣�ĺ�,��ĳЩģ�����ϻ�ֱ�ӱ���                    	
//                        throw new IllegalStateException("Could not execute non "
//                                + "public method of the activity", e);

                    } 
                    catch (InvocationTargetException e) 
                    {
                    	Functions.ShowMessage(handlerName + "����ִ���쳣(ע���������).", activity);
                    	return;                    	
//                        throw new IllegalStateException("Could not execute "
//                                + "method of the activity", e);

                    }
                    catch (Exception e) 
                    {
                    	Functions.ShowMessage(handlerName + "����ִ���쳣(ע���������)." + e.getMessage(), activity);
                    	return;
                    }                    
                    //try

                }//public 

            });//setOnClickListener

		
	}//

}//

