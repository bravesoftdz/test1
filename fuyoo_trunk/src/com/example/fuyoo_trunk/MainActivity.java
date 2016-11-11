package com.example.fuyoo_trunk;

import android.os.Bundle;
import android.app.Activity;
import android.view.Menu;
import android.view.View;
import apublic.*;
import android.view.*;
import android.widget.*;
import android.content.*; //for Intent


public class MainActivity extends Activity 
{
	MainActivity _this;

    @Override
    protected void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        
        //--------------------------------------------------
        _this = this;
        //--------------------------------------------------
        //ȫ��,����ʾ����ͷ
        Functions.SetFullScreen(this);
        
        //
        //ȷ������Ĳ���
		AbsoluteLayout abslayout = new AbsoluteLayout(this);
        setContentView(abslayout);
        
        View temp = new View(this);

        temp.setId(1);

        //this.addView(temp);
        
        //����һ��button��ť
        Button btn1 = new Button(this);
        btn1.setText("this is a button");
        btn1.setId(1);
        //ȷ������ؼ��Ĵ�С��λ��
        AbsoluteLayout.LayoutParams lp1 =
	        new AbsoluteLayout.LayoutParams(
		        ViewGroup.LayoutParams.WRAP_CONTENT,
		        ViewGroup.LayoutParams.WRAP_CONTENT,
		        0,100);
        abslayout.addView(btn1, lp1);
        
        //���ð�ť�¼�
        SetOnClick(btn1);
        
        //--------------------------------------------------
        //ע��,�����Ĭ��  xml �ļ����,�������Ķ�̬������ͻ��
        //setContentView(R.layout.activity_main);
    }//


    @Override
    public boolean onCreateOptionsMenu(Menu menu) 
    {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }//
    
    
    //���ð�ť�¼�
    void SetOnClick(Button button)
    {
    	MainActivity tmp = this;
    	button.setOnClickListener(new Button.OnClickListener() { //��׼ȷ��Ӧ����View.OnClickListener
    	    public void onClick(View v)
    	    {
    	        //this.ShowLogin(); //no
    	        //tmp.ShowLogin(); //no
    	    	_this.ShowLogin(); //yes
    	    }
    	});    	
    	
    }//
    
    //��ͨ��
    void ShowLogin1()
    {
        //�½�һ��Intent���� 
        Intent intent = new Intent();
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);  
        ////intent.putExtra("name","LeiPei");    
        //ָ��intentҪ��������
        intent.setClass(MainActivity.this, FormLogin.class); //no,���Ϊ���ֹ��಻��//�ֹ��½�����  Activity ������ AndroidManifest.xml  �ļ�������
        //intent.setClass(MainActivity.this, FormT1.class); //ok
        //����һ���µ�Activity
        MainActivity.this.startActivity(intent);
        //�رյ�ǰ��Activity
        MainActivity.this.finish();
    	
    }//
    
    //������
    void ShowLogin()
    {
        //�½�һ��Intent���� 
    	Intent intent = new Intent(MainActivity.this, FormLogin.class);
        //intent.putExtra("type", Constant.REGIST_CHOOSE_XIAOQU);
        //startActivityForResult(intent, Constant.REGIST_CHOOSE_XIAOQU);
    	MainActivity.this.startActivity(intent);
        overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out); //�����˳��Ķ���,�����ʾ������ xml �е�

        
        MainActivity.this.finish();
    	
    }//    
    
    
}//

