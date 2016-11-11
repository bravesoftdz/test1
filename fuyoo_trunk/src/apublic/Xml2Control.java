package apublic;

import java.util.Hashtable; //��˵ Hashtable �߳�ͬ��, hashmap ��ͬ��
import android.view.*;
import android.app.Activity;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList; 

import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.*;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

//����ͬ ios Xml2Control.h

//����,Ҫ���ļ�
//public class Hashtable_controls extends Hashtable<String, View>
//{}//

public class Xml2Control
{
	
	//�� xml ��װ�����пؼ�//��Դ�ļ�·��
	public Hashtable<String, View> LoadFromXml(String fileName, View view, Hashtable<String, View> controls)
	{
		
		
		return controls;
	}//
	
	
	//�� xml ��װ�����пؼ�//����ȫ·��
	public Hashtable<String, View> LoadFromXml_FullFileName(String fileName, View view, Hashtable<String, View> controls)
	{

	    if (controls == null) controls = new Hashtable<String, View>();
	    
    	//--------------------------------------------------
    	//�ȴ��� xml ����
    	DocumentBuilderFactory factory=null;
        DocumentBuilder builder=null;
        Document document=null;
        InputStream inputStream=null;
        //List<River> rivers=new ArrayList<River>();
        
        String errorXml = "�������";	    
        
        //--------------------------------------------------

	    //NSString *path = fileName; //֧��ȫ·���ȽϺ�
	    
        factory = DocumentBuilderFactory.newInstance();
        String s = "";
        try {
        	//--------------------------------------------------
        	//���ǽ�����Ŀ���Դ���ʾ�� xml
            //�ҵ�xml���������ĵ�
            //inputStream = this.getResources().getAssets().open("ud_op_test2.xml");//������ʹ��assetsĿ¼�е�river.xml�ļ� ��ʵ���Դ�  url �����������ļ���ȡ
            inputStream = new FileInputStream(fileName);//�������ļ���ȡ,���� sd ����
            
            InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "gbk");
            BufferedReader in = new BufferedReader(inputStreamReader);
            StringBuffer sBuffer = new StringBuffer();
            sBuffer.append(in.readLine() + "\n");
            s = sBuffer.toString();
            
            //--------------------------------------------------
            //���ǽ���������ȡ�õ� xml
            //��һ���ַ������� xml ����,������ɹ���ֱ����ʾ��ԭʼ������Ϊ������Ϣ������
            //inputStream = new ByteArrayInputStream(errorXml.getBytes("ISO-8859-1"));
            //inputStream = new ByteArrayInputStream(s.getBytes());//��ʱ���ַ����Ѿ�ת������,���Բ���Ҫ�ٴ�  gbk ��ת����־

            //--------------------------------------------------
            builder = factory.newDocumentBuilder();
            document = builder.parse(inputStream);//����Ϊ��ʾ������������ inputStream ,ʵ����Ŀ��ֻ��ʹ������һ��
            
            //�ҵ���Element
            Element root = document.getDocumentElement();
            Functions.ShowMessage(root.getTagName(), (Activity)view.getContext());//����õ�  <Root> �ڵ�
            //����� delphi �ǲ�ͬ��
            Element itemList = (Element)root.getElementsByTagName("Data").item(0);
            //Functions.ShowMessage(itemList.getTagName(), this);//����õ�  <ItemList> �ڵ�
            NodeList nodes = itemList.getElementsByTagName("Row");
	    
    	    //NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile: path];

    	    //NSError *error;
    	    
    	    //��һ���ڵ�ʵ�����ǿհ�,����ֱ�������ǲ��е�//[Xml2Control CreateControls:doc.rootElement parent:view controls:dictionary];
          //���������ӽڵ�
            for(int i=0;i<nodes.getLength();i++)
            {
                //��ȡԪ�ؽڵ�
                Element node=(Element)(nodes.item(i));
            }
            //
//    	    for (int i=0; i<doc.rootElement.childCount; i++)
//    	    {
//    	        GDataXMLElement * node = doc.rootElement.children[i];
//    	        
//    	        [Xml2Control CreateControls:node parent:view controls:controls];
//    	        
//    	    }//for
    	    
        }//try
        catch (Exception e)
        {
            e.printStackTrace();
            
            try {
            	//Functions.ShowMessage("<�����ڳ���ʱֱ����ʾҪ������  xml Դ�����>" + new String(errorXml.getBytes("ISO-8859-1"), "unicode"), this);
            	Functions.ShowMessage("<�����ڳ���ʱֱ����ʾҪ������  xml Դ�����>" + s, (Activity)view.getContext());
            } catch (Exception e_codepage) {   
            	e_codepage.printStackTrace();
            }
        } 
//        catch (SAXException e) {
//            e.printStackTrace();
//        }
//         catch (ParserConfigurationException e) {
//            e.printStackTrace();
//        }
        finally
        {
            try 
            {
                inputStream.close();
            } catch (IOException e) {   
                e.printStackTrace();
            }
        }//try
	    
	    
	    return controls;		

	}//

	
}//




