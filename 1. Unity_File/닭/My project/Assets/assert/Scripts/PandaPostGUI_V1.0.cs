using System;
using UnityEngine;
using UnityEditor;


//����һ��GUI��
public class PostGUI : ShaderGUI
{
    public GUILayoutOption[] shortButtonStyle = new GUILayoutOption[] { GUILayout.Width(200) };

    public GUIStyle style = new GUIStyle() ;

    static bool Foldout(bool display, string title)
    {




        var style = new GUIStyle("ShurikenModuleTitle");
        style.font = new GUIStyle(EditorStyles.boldLabel).font;
        style.border = new RectOffset(15, 7, 4, 4);
        style.fixedHeight = 22;
        style.contentOffset = new Vector2(20f, -2f);
        style.fontSize = 11;
        style.normal.textColor = new Color(0.7f, 0.8f, 0.9f);


        var rect = GUILayoutUtility.GetRect(16f, 25f, style);
        GUI.Box(rect, title, style);

        var e = Event.current;

        var toggleRect = new Rect(rect.x + 4f, rect.y + 2f, 13f, 13f);
        if (e.type == EventType.Repaint)
        {
            EditorStyles.foldout.Draw(toggleRect, false, false, display, false);
        }

        if (e.type == EventType.MouseDown && rect.Contains(e.mousePosition))
        {
            display = !display;
            e.Use();
        }

        return display;
    }

    static bool Foldouts(bool display, string title)
    {



        var style = new GUIStyle("ShurikenModuleTitle");
        style.font = new GUIStyle(EditorStyles.boldLabel).font;
        style.border = new RectOffset(15, 7, 4, 4);
        style.fixedHeight = 18;
        style.contentOffset = new Vector2(30f, -2f);
        style.fontSize = 10;
        style.normal.textColor = new Color(0.75f, 0.75f, 0.75f);


        var rect = GUILayoutUtility.GetRect(16f, 15f, style);
        GUI.Box(rect, title, style);

        var e = Event.current;

        var toggleRect = new Rect(rect.x + 15f, rect.y + 2f, 13f, 13f);
        if (e.type == EventType.Repaint)
        {
            EditorStyles.foldout.Draw(toggleRect, false, false, display, false);
        }

        if (e.type == EventType.MouseDown && rect.Contains(e.mousePosition))
        {
            display = !display;
            e.Use();
        }

        return display;
    }


    static bool _Main = true;

    static bool _Base = true;

    static bool _Texxx = false;

    static bool _tips = false;

    static bool _Thanks = false;

    static bool _honglan = false;

    static bool _UVDistort = false;

    static bool _Black = false;

    static bool _Texx = false;

    static bool _Logox = false;

    static bool _Logoxx = false;
    static bool _zhenping = false;
    MaterialEditor m_MaterialEditor;


    MaterialProperty ColorStyle = null;
    MaterialProperty centerU = null;
    MaterialProperty centerV = null;
    MaterialProperty Color1 = null;
    MaterialProperty Color2 = null;
    MaterialProperty LineTilingU = null;
    MaterialProperty LineTilingV = null;
    MaterialProperty LineUVScale = null;
    MaterialProperty LineUVScaleK = null;
    MaterialProperty LineColorScale = null;
    MaterialProperty LineOffset = null;
    MaterialProperty BlurFactor = null;
    MaterialProperty BlurFactorK = null;
    MaterialProperty Soft = null;
    MaterialProperty StepFactor = null;
    MaterialProperty StepFactorK = null;
    MaterialProperty RedBlueFactor = null;
    MaterialProperty RedBlueFactorK = null;
    MaterialProperty Tex = null;
    MaterialProperty TexRotator = null;
    MaterialProperty TexAlpha = null;
    MaterialProperty VignettePower = null;
    MaterialProperty VignetteScale = null;
    MaterialProperty MainAlpha = null;
    MaterialProperty MainAlphaK = null;
    MaterialProperty IfMainAlpha = null;
    MaterialProperty IfStepFactor = null;
    MaterialProperty IfLineUVScale = null;
    MaterialProperty IfBlurFactor = null;
    MaterialProperty IfRedBlueFactor = null;
    MaterialProperty Logo = null;
    MaterialProperty LogoAR = null;
    MaterialProperty LogoAlpha = null;
    MaterialProperty zhenfu = null;
    MaterialProperty zhenfuK = null;
    MaterialProperty Ifzhenfu = null;
    MaterialProperty zhenpin = null;
    MaterialProperty zhenpinK = null;
    MaterialProperty Ifzhenpin = null;
    MaterialProperty IfVignettePower = null;
    MaterialProperty VignettePowerK = null;
    MaterialProperty IfVignetteScale = null;
    MaterialProperty VignetteScaleK = null;

    MaterialProperty TexAR = null;

    public void FindProperties(MaterialProperty[] props)
    {


        ColorStyle = FindProperty("_ColorStyle", props);
        centerU = FindProperty("_centerU", props);
        centerV = FindProperty("_centerV", props);
        Color1 = FindProperty("_Color1", props);
        Color2 = FindProperty("_Color2", props);
        LineTilingU = FindProperty("_LineTilingU", props);
        LineTilingV = FindProperty("_LineTilingV", props);
        LineUVScale = FindProperty("_LineUVScale", props);
        LineUVScaleK = FindProperty("_LineUVScaleK", props);
        IfLineUVScale = FindProperty("_IfLineUVScale", props);
        LineColorScale = FindProperty("_LineColorScale", props);
        LineOffset = FindProperty("_LineOffset", props);
        BlurFactor = FindProperty("_BlurFactor", props);
        BlurFactorK = FindProperty("_BlurFactorK", props);
        IfBlurFactor = FindProperty("_IfBlurFactor", props);
        Soft = FindProperty("_Soft", props);
        StepFactor = FindProperty("_StepFactor", props);
        StepFactorK = FindProperty("_StepFactorK", props);
        IfStepFactor = FindProperty("_IfStepFactor", props);
        RedBlueFactor = FindProperty("_RedBlueFactor", props);
        RedBlueFactorK = FindProperty("_RedBlueFactorK", props);
        IfRedBlueFactor = FindProperty("_IfRedBlueFactor", props);
        Tex = FindProperty("_Tex", props);
        TexRotator = FindProperty("_TexRotator", props);
        TexAlpha = FindProperty("_TexAlpha", props);
        VignettePower = FindProperty("_VignettePower", props);
        VignetteScale = FindProperty("_VignetteScale", props);
        MainAlpha = FindProperty("_MainAlpha", props);
        MainAlphaK = FindProperty("_MainAlphaK", props);
        IfMainAlpha = FindProperty("_IfMainAlpha", props);
        LogoAR = FindProperty("_LogoAR", props);
        Logo = FindProperty("_Logo", props);
        LogoAlpha= FindProperty("_LogoAlpha", props);
        zhenfu = FindProperty("_zhenfu", props);
        zhenfuK = FindProperty("_zhenfuK", props);
        Ifzhenfu = FindProperty("_Ifzhenfu", props);
        zhenpin = FindProperty("_zhenpin", props);
        zhenpinK = FindProperty("_zhenpinK", props);
        Ifzhenpin = FindProperty("_Ifzhenpin", props);
        IfVignettePower = FindProperty("_IfVignettePower", props);
        VignettePowerK = FindProperty("_VignettePowerK", props);
        VignetteScaleK = FindProperty("_VignetteScaleK", props);
        IfVignetteScale = FindProperty("_IfVignetteScale", props);
        TexAR = FindProperty("_TexAR", props);
    }

    //�����涨���������ʾ�������
    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] props)
    {
      

        FindProperties(props);

        m_MaterialEditor = materialEditor;

        Material material = materialEditor.target as Material;


        EditorGUILayout.BeginVertical(EditorStyles.helpBox);

        _Main = Foldout(_Main, "��ɫģʽ(ColorStyle)");

        if (_Main)
        {
            EditorGUI.indentLevel++;


            

            EditorGUI.indentLevel--;
        }
        EditorGUILayout.EndVertical();


        EditorGUILayout.BeginVertical(EditorStyles.helpBox);
        _UVDistort = Foldout(_UVDistort, "����ģ��(RadialBlur)");

        if (_UVDistort)
        {
            EditorGUI.indentLevel++;


            UVDistort(material);

            EditorGUI.indentLevel--;
        }
        EditorGUILayout.EndVertical();


        EditorGUILayout.BeginVertical(EditorStyles.helpBox);
        _honglan = Foldout(_honglan, "����ɫɢ(Chromatic)");

        if (_honglan)
        {
            EditorGUI.indentLevel++;


            honglangui(material);

            EditorGUI.indentLevel--;
        }
        EditorGUILayout.EndVertical();




        EditorGUILayout.BeginVertical(EditorStyles.helpBox);
        _zhenping = Foldout(_zhenping, "����(ScreenShake)");

        if (_zhenping)
        {
            EditorGUI.indentLevel++;


            zhenpinggui(material);

            EditorGUI.indentLevel--;
        }
        EditorGUILayout.EndVertical();






        EditorGUILayout.BeginVertical(EditorStyles.helpBox);

        _Black = Foldout(_Black, "�ڱ߿�(Vignette)");

        if (_Black)
        {
            EditorGUI.indentLevel++;


            Black(material);

            EditorGUI.indentLevel--;
        }
        EditorGUILayout.EndVertical();


        EditorGUILayout.BeginVertical(EditorStyles.helpBox);
        _Texx = Foldout(_Texx, "����ͼ(Texture)");

        if (_Texx)
        {
            EditorGUI.indentLevel++;


            Textures(material);

            EditorGUI.indentLevel--;
        }
        EditorGUILayout.EndVertical();


        EditorGUILayout.BeginVertical(EditorStyles.helpBox);
        _Logox = Foldout(_Logox, "ˮӡ(Logo)");

        if (_Logox)
        {
            EditorGUI.indentLevel++;


            Logogui(material);

            EditorGUI.indentLevel--;
        }
        EditorGUILayout.EndVertical();


        EditorGUILayout.BeginVertical(EditorStyles.helpBox);

        _Base = Foldout(_Base, "�����ۺ�����(PostComprehensiveSettings)");

        if (_Base)
        {
            EditorGUI.indentLevel++;


            Base(material);

            EditorGUI.indentLevel--;
        }
        EditorGUILayout.EndVertical();


        EditorGUILayout.BeginVertical(EditorStyles.helpBox);
        _Thanks = Foldout(_Thanks, "˵��(Illustrate)");

        if (_Thanks)
        {
            EditorGUI.indentLevel++;


            Thanks(material);

            EditorGUI.indentLevel--;
        }
        EditorGUILayout.EndVertical();






        void Main()
        {
            

            m_MaterialEditor.ShaderProperty(ColorStyle, "��ɫģʽ");



            if (_tips == true)
            {

                EditorGUILayout.BeginVertical(EditorStyles.helpBox);
                style.fontSize = 10;
                style.normal.textColor = new Color(0.5f, 0.5f, 0.5f);
                style.wordWrap = true;
                GUILayout.Label("*NormalΪ����ɫģʽ��BlackWhiteΪ�ڰ�ɫģʽ��ReCoverΪ��ɫģʽ", style);
                EditorGUILayout.EndVertical();
            }

          
            GUILayout.Space(5);

            

            if (material.GetFloat("_ColorStyle") == 1)
            {



                EditorGUILayout.BeginVertical(EditorStyles.helpBox);

                GUILayout.Space(5);

                m_MaterialEditor.ShaderProperty(Color1, "��ɫ1");
                m_MaterialEditor.ShaderProperty(Color2, "��ɫ2");
                if (_tips == true)
                {

                    EditorGUILayout.BeginVertical(EditorStyles.helpBox);
                    style.fontSize = 10;
                    style.normal.textColor = new Color(0.5f, 0.5f, 0.5f);
                    GUILayout.Label("*����ɫ�����������������ɫ���ڰף��ں�ȵ�", style);
                    EditorGUILayout.EndVertical();
                }
                GUILayout.Space(5);
          
                m_MaterialEditor.ShaderProperty(Soft, "������Ӳ�̶�");
                if (_tips == true)
                {

                    EditorGUILayout.BeginVertical(EditorStyles.helpBox);
                    style.fontSize = 10;
                    style.normal.textColor = new Color(0.5f, 0.5f, 0.5f);
                    GUILayout.Label("*������ɫ�Ľ����ݶȣ�ֵԽ���ݶ�Խ��������Խ����", style);
                    EditorGUILayout.EndVertical();
                }

                GUILayout.Space(5);

                m_MaterialEditor.ShaderProperty(StepFactor, "�����޳��̶�");
                if (_tips == true)
                {

                    EditorGUILayout.BeginVertical(EditorStyles.helpBox);
                    style.fontSize = 10;
                    style.normal.textColor = new Color(0.5f, 0.5f, 0.5f);
                    GUILayout.Label("*������ɫ���޳���Сֵ��С�ڸ�ֵ���ᱻ�޳���Ϊ��ɫ", style);
                    EditorGUILayout.EndVertical();
                }
                GUILayout.Space(5);
                m_MaterialEditor.ShaderProperty(LineColorScale, "�����߶�ǿ��");
                if (_tips == true)
                {

                    EditorGUILayout.BeginVertical(EditorStyles.helpBox);
                    style.fontSize = 10;
                    style.normal.textColor = new Color(0.5f, 0.5f, 0.5f);
                    GUILayout.Label("*����һЩ����ķ�����������ӳ���У��������ܶȺͷ�������ͬ����ģ��һ�£������ھ���ģ��������", style);
                    EditorGUILayout.EndVertical();
                }
                GUILayout.Space(5);
                EditorGUILayout.EndVertical();


            }




       

            EditorGUILayout.BeginVertical(EditorStyles.helpBox);


         
            EditorGUILayout.BeginHorizontal();


            EditorGUILayout.PrefixLabel("��͸����K֡");
            if (material.GetFloat("_IfMainAlpha") == 0)
            {
                if (GUILayout.Button("�ѹرգ�MainAlpha��", shortButtonStyle))
                {
                    material.SetFloat("_IfMainAlpha",1);

                }
            }
            else

            {
                if (GUILayout.Button("�ѿ�����MainAlpha��", shortButtonStyle))
                {
                    material.SetFloat("_IfMainAlpha", 0);

                }
            }

            EditorGUILayout.EndHorizontal();

            if (_tips == true)
            {

                EditorGUILayout.BeginVertical(EditorStyles.helpBox);
                style.fontSize = 10;
                style.normal.textColor = new Color(0.5f, 0.5f, 0.5f);
                GUILayout.Label("*��Ҫ������AlphaK֡����������Ҫ������ѡ��������·���͸������ֵ��ʧЧ�����أ�����ֵ�����Ϸ��ű�PandaPostProcess�ڵ�MainAplha���ƣ�K֡Ҳ����ҪK�ű������ֵ���������ϵĲ�����֧��K֡", style);
                EditorGUILayout.EndVertical();
            }








            if (material.GetFloat("_IfMainAlpha") == 0)
            {

                m_MaterialEditor.ShaderProperty(MainAlpha, "��͸����");
                if (_tips == true)
                {

                    EditorGUILayout.BeginVertical(EditorStyles.helpBox);
                    style.fontSize = 10;
                    style.normal.textColor = new Color(0.5f, 0.5f, 0.5f);
                    GUILayout.Label("*�ڰ�������ɫ������ģ��������ƫ�ƵĻ��Ч��������͸����", style);
                    EditorGUILayout.EndVertical();
                }
            }
            EditorGUILayout.EndVertical();
            GUILayout.Space(5);





        }




    }



        void UVDistort(Material material)

        {


        EditorGUILayout.BeginVertical(EditorStyles.helpBox);
        m_MaterialEditor.ShaderProperty(centerU, "���ĵ�U");


        m_MaterialEditor.ShaderProperty(centerV, "���ĵ�V");
        EditorGUILayout.EndVertical();
        if (_tips == true)
        {

            EditorGUILayout.BeginVertical(EditorStyles.helpBox);
            style.fontSize = 10;
            style.normal.textColor = new Color(0.5f, 0.5f, 0.5f);
            GUILayout.Label("*�������ĵ㣬ͬʱ����UV���죬����ƫ�ƣ�����ģ������������������λ��", style);
            EditorGUILayout.EndVertical();
        }
        GUILayout.Space(5);

      



        EditorGUILayout.BeginVertical(EditorStyles.helpBox);
        EditorGUILayout.BeginHorizontal();


        EditorGUILayout.PrefixLabel("����ģ��ǿ��K֡");
        if (material.GetFloat("_IfBlurFactor") == 0)
        {
            if (GUILayout.Button("�ѹرգ�BlurFactor��", shortButtonStyle))
            {
                material.SetFloat("_IfBlurFactor", 1);

            }
        }
        else

        {
            if (GUILayout.Button("�ѿ�����BlurFactor��", shortButtonStyle))
            {
                material.SetFloat("_IfBlurFactor", 0);

            }
          
        }

        EditorGUILayout.EndHorizontal();
        if (_tips == true)
        {

            EditorGUILayout.BeginVertical(EditorStyles.helpBox);
            style.fontSize = 10;
            style.normal.textColor = new Color(0.5f, 0.5f, 0.5f);
            GUILayout.Label("*��Ҫ�Ծ���ģ��ǿ��K֡����������Ҫ������ѡ��������·�����ģ��ǿ����ֵ��ʧЧ�����أ�����ֵ�����Ϸ��ű�PandaPostProcess�ڵ�BlurFactor���ƣ�K֡Ҳ����ҪK�ű������ֵ���������ϵĲ�����֧��K֡", style);
            EditorGUILayout.EndVertical();
        }

        if (material.GetFloat("_IfBlurFactor") == 0)
        { 

            m_MaterialEditor.ShaderProperty(BlurFactor, "����ģ��ǿ��");

        }
        EditorGUILayout.EndVertical();



        GUILayout.Space(5);

   



        EditorGUILayout.BeginVertical(EditorStyles.helpBox);
        EditorGUILayout.BeginHorizontal();


        EditorGUILayout.PrefixLabel("UV����ǿ��K֡");
        if (material.GetFloat("_IfLineUVScale") == 0)
        {
            if (GUILayout.Button("�ѹرգ�LineUVScale��", shortButtonStyle))
            {
                material.SetFloat("_IfLineUVScale", 1);

            }
        }
        else

        {
            if (GUILayout.Button("�ѿ�����LineUVScale��", shortButtonStyle))
            {
                material.SetFloat("_IfLineUVScale", 0);

            }

        }

        EditorGUILayout.EndHorizontal();

        if (_tips == true)
        {

            EditorGUILayout.BeginVertical(EditorStyles.helpBox);
            style.fontSize = 10;
            style.normal.textColor = new Color(0.5f, 0.5f, 0.5f);
            GUILayout.Label("*��Ҫ��UV����ǿ��K֡����������Ҫ������ѡ��������·�UV����ǿ����ֵ��ʧЧ�����أ�����ֵ�����Ϸ��ű�PandaPostProcess�ڵ�LineUVScale���ƣ�K֡Ҳ����ҪK�ű������ֵ���������ϵĲ�����֧��K֡", style);
            EditorGUILayout.EndVertical();
        }


        if (material.GetFloat("_IfLineUVScale") == 0)
        {
            m_MaterialEditor.ShaderProperty(LineUVScale, "UV����ǿ��");
            if (_tips == true)
            {

                EditorGUILayout.BeginVertical(EditorStyles.helpBox);
                style.fontSize = 10;
                style.normal.textColor = new Color(0.5f, 0.5f, 0.5f);
                GUILayout.Label("*UV����״����̶�", style);
                EditorGUILayout.EndVertical();
            }
        }

        EditorGUILayout.EndVertical();
          GUILayout.Space(5);





        EditorGUILayout.BeginVertical(EditorStyles.helpBox);
        m_MaterialEditor.ShaderProperty(LineTilingU, "�߶���������");

        m_MaterialEditor.ShaderProperty(LineTilingV, "�߶κ�������");
        if (_tips == true)
        {

            EditorGUILayout.BeginVertical(EditorStyles.helpBox);
            style.fontSize = 10;
            style.normal.textColor = new Color(0.5f, 0.5f, 0.5f);
            GUILayout.Label("*�����߶ε����̶ȣ�����Ϊ����������Ե��������̶ȣ�����Ϊ���η������̶�", style);
            EditorGUILayout.EndVertical();
        }
        EditorGUILayout.EndVertical();


        GUILayout.Space(5);









        m_MaterialEditor.ShaderProperty(LineOffset, "�߶�ƫ��");
        if (_tips == true)
        {

            EditorGUILayout.BeginVertical(EditorStyles.helpBox);
            style.fontSize = 10;
            style.normal.textColor = new Color(0.5f, 0.5f, 0.5f);
            GUILayout.Label("*�����߶ε�ƫ��ֵ�����Ե�����ѡһ��Ư�����߶�״̬", style);
            EditorGUILayout.EndVertical();
        }

        GUILayout.Space(5);





   







        }


    void honglangui(Material material)
    {

        EditorGUILayout.BeginVertical(EditorStyles.helpBox);
        EditorGUILayout.BeginHorizontal();


        EditorGUILayout.PrefixLabel("ɫɢǿ��K֡");
        if (material.GetFloat("_IfRedBlueFactor") == 0)
        {
            if (GUILayout.Button("�ѹرգ�Chromatic��", shortButtonStyle))
            {
                material.SetFloat("_IfRedBlueFactor", 1);

            }
        }
        else

        {
            if (GUILayout.Button("�ѿ�����Chromatic��", shortButtonStyle))
            {
                material.SetFloat("_IfRedBlueFactor", 0);

            }

        }

        EditorGUILayout.EndHorizontal();


        if (_tips == true)
        {

            EditorGUILayout.BeginVertical(EditorStyles.helpBox);
            style.fontSize = 10;
            style.normal.textColor = new Color(0.5f, 0.5f, 0.5f);
            GUILayout.Label("*��Ҫ��ɫɢǿ��K֡����������Ҫ������ѡ��������·�ɫɢǿ����ֵ��ʧЧ�����أ�����ֵ�����Ϸ��ű�PandaPostProcess�ڵ�Chromatic���ƣ�K֡Ҳ����ҪK�ű������ֵ���������ϵĲ�����֧��K֡", style);
            EditorGUILayout.EndVertical();
        }

        if (material.GetFloat("_IfRedBlueFactor") == 0)
        {

            m_MaterialEditor.ShaderProperty(RedBlueFactor, "ɫɢǿ��");
            if (_tips == true)
            {

                EditorGUILayout.BeginVertical(EditorStyles.helpBox);
                style.fontSize = 10;
                style.normal.textColor = new Color(0.5f, 0.5f, 0.5f);
                GUILayout.Label("*����״����ƫ�Ƴ̶�", style);
                EditorGUILayout.EndVertical();
            }
        }

        EditorGUILayout.EndVertical();



        GUILayout.Space(5);

    }
    void zhenpinggui(Material material)
    {

        EditorGUILayout.BeginVertical(EditorStyles.helpBox);



        EditorGUILayout.BeginHorizontal();


        EditorGUILayout.PrefixLabel("��ƵK֡");
        if (material.GetFloat("_Ifzhenpin") == 0)
        {
            if (GUILayout.Button("�ѹرգ�Frequency��", shortButtonStyle))
            {
                material.SetFloat("_Ifzhenpin", 1);

            }
        }
        else

        {
            if (GUILayout.Button("�ѿ�����Frequency��", shortButtonStyle))
            {
                material.SetFloat("_Ifzhenpin", 0);

            }
        }

        EditorGUILayout.EndHorizontal();
        if (_tips == true)
        {

            EditorGUILayout.BeginVertical(EditorStyles.helpBox);
            style.fontSize = 10;
            style.normal.textColor = new Color(0.5f, 0.5f, 0.5f);
            GUILayout.Label("*��Ҫ����ƵK֡����������Ҫ������ѡ��������·���Ƶ��ֵ��ʧЧ�����أ�����ֵ�����Ϸ��ű�PandaPostProcess�ڵ�Frequency���ƣ�K֡Ҳ����ҪK�ű������ֵ���������ϵĲ�����֧��K֡", style);
            EditorGUILayout.EndVertical();
        }


        if (material.GetFloat("_Ifzhenpin") == 0)
        {

            m_MaterialEditor.ShaderProperty(zhenpin, "��Ƶ");
            if (_tips == true)
            {

                EditorGUILayout.BeginVertical(EditorStyles.helpBox);
                style.fontSize = 10;
                style.normal.textColor = new Color(0.5f, 0.5f, 0.5f);
                GUILayout.Label("*��Ļ�𶯵�Ƶ�ʣ�ֵԽ���𶯵�Ƶ��Խ��", style);
                EditorGUILayout.EndVertical();
            }
        }
        EditorGUILayout.EndVertical();
        GUILayout.Space(5);





        EditorGUILayout.BeginVertical(EditorStyles.helpBox);



        EditorGUILayout.BeginHorizontal();


        EditorGUILayout.PrefixLabel("���K֡");
        if (material.GetFloat("_Ifzhenfu") == 0)
        {
            if (GUILayout.Button("�ѹرգ�Amplitude��", shortButtonStyle))
            {
                material.SetFloat("_Ifzhenfu", 1);

            }
        }
        else

        {
            if (GUILayout.Button("�ѿ�����Amplitude��", shortButtonStyle))
            {
                material.SetFloat("_Ifzhenfu", 0);

            }
        }

        EditorGUILayout.EndHorizontal();

        if (_tips == true)
        {

            EditorGUILayout.BeginVertical(EditorStyles.helpBox);
            style.fontSize = 10;
            style.normal.textColor = new Color(0.5f, 0.5f, 0.5f);
            GUILayout.Label("*��Ҫ�����K֡����������Ҫ������ѡ��������·������ֵ��ʧЧ�����أ�����ֵ�����Ϸ��ű�PandaPostProcess�ڵ�Amplitude���ƣ�K֡Ҳ����ҪK�ű������ֵ���������ϵĲ�����֧��K֡", style);
            EditorGUILayout.EndVertical();
        }

        if (material.GetFloat("_Ifzhenfu") == 0)
        {

            m_MaterialEditor.ShaderProperty(zhenfu, "���");
            if (_tips == true)
            {

                EditorGUILayout.BeginVertical(EditorStyles.helpBox);
                style.fontSize = 10;
                style.normal.textColor = new Color(0.5f, 0.5f, 0.5f);
                GUILayout.Label("*��Ļ�𶯵ķ��ȣ�ֵԽ���𶯵ķ���Խ��", style);
                EditorGUILayout.EndVertical();
            }
        }
        EditorGUILayout.EndVertical();
        GUILayout.Space(5);

    }



    void Black(Material material)

        {
           

        EditorGUILayout.BeginVertical(EditorStyles.helpBox);



        EditorGUILayout.BeginHorizontal();


        EditorGUILayout.PrefixLabel("�ڱ߿���K֡");
        if (material.GetFloat("_IfVignettePower") == 0)
        {
            if (GUILayout.Button("�ѹرգ�VignettePower��", shortButtonStyle))
            {
                material.SetFloat("_IfVignettePower", 1);

            }
        }
        else

        {
            if (GUILayout.Button("�ѿ�����VignettePower��", shortButtonStyle))
            {
                material.SetFloat("_IfVignettePower", 0);

            }
        }

        EditorGUILayout.EndHorizontal();

        if (_tips == true)
        {

            EditorGUILayout.BeginVertical(EditorStyles.helpBox);
            style.fontSize = 10;
            style.normal.textColor = new Color(0.5f, 0.5f, 0.5f);
            GUILayout.Label("*��Ҫ�Ժڱ߿���K֡����������Ҫ������ѡ��������·��ڱ߿�����ֵ��ʧЧ�����أ�����ֵ�����Ϸ��ű�PandaPostProcess�ڵ�VignettePower���ƣ�K֡Ҳ����ҪK�ű������ֵ���������ϵĲ�����֧��K֡", style);
            EditorGUILayout.EndVertical();
        }

        if (material.GetFloat("_IfVignettePower") == 0)
        {

            m_MaterialEditor.ShaderProperty(VignettePower, "�ڱ߿���");
    
        }
        EditorGUILayout.EndVertical();
        GUILayout.Space(5);



        EditorGUILayout.BeginVertical(EditorStyles.helpBox);



        EditorGUILayout.BeginHorizontal();


        EditorGUILayout.PrefixLabel("�ڱ߿�ǿ��K֡");
        if (material.GetFloat("_IfVignetteScale") == 0)
        {
            if (GUILayout.Button("�ѹرգ�VignetteScale��", shortButtonStyle))
            {
                material.SetFloat("_IfVignetteScale", 1);

            }
        }
        else

        {
            if (GUILayout.Button("�ѿ�����VignetteScale��", shortButtonStyle))
            {
                material.SetFloat("_IfVignetteScale", 0);

            }
        }

        EditorGUILayout.EndHorizontal();

        if (_tips == true)
        {

            EditorGUILayout.BeginVertical(EditorStyles.helpBox);
            style.fontSize = 10;
            style.normal.textColor = new Color(0.5f, 0.5f, 0.5f);
            GUILayout.Label("*��Ҫ�Ժڱ߿�ǿ��K֡����������Ҫ������ѡ��������·��ڱ߿�ǿ����ֵ��ʧЧ�����أ�����ֵ�����Ϸ��ű�PandaPostProcess�ڵ�VignetteScale���ƣ�K֡Ҳ����ҪK�ű������ֵ���������ϵĲ�����֧��K֡", style);
            EditorGUILayout.EndVertical();
        }

        if (material.GetFloat("_IfVignetteScale") == 0)
        {

            m_MaterialEditor.ShaderProperty(VignetteScale, "�ڱ߿�ǿ��");

        }
        EditorGUILayout.EndVertical();
        GUILayout.Space(5);




    }

        void Textures(Material material)

        {
          
            m_MaterialEditor.TexturePropertySingleLine(new GUIContent("��ͼ"), Tex);
            if (_tips == true)
            {

                EditorGUILayout.BeginVertical(EditorStyles.helpBox);
                style.fontSize = 10;
                style.normal.textColor = new Color(0.5f, 0.5f, 0.5f);
                GUILayout.Label("*��������������Ļ����", style);
                EditorGUILayout.EndVertical();
            }


            if (Tex.textureValue != null)
            {

                EditorGUILayout.BeginVertical(EditorStyles.helpBox);
                _Texxx = Foldouts(_Texxx, "��ͼ����");

                if (_Texxx)
                {
                    EditorGUI.indentLevel++;


                m_MaterialEditor.ShaderProperty(TexAR, "ʹ��Rͨ��");
                if (_tips == true)
                {

                    EditorGUILayout.BeginVertical(EditorStyles.helpBox);
                    style.fontSize = 10;
                    style.normal.textColor = new Color(0.5f, 0.5f, 0.5f);
                    GUILayout.Label("*��ѡ��ʹ��Rͨ��Ϊ����ͨ��������ѡʹ��Aͨ��Ϊ����ͨ����ͼƬ��Aͨ����Ҫ��ѡ��", style);
                    EditorGUILayout.EndVertical();
                }

                m_MaterialEditor.ShaderProperty(TexRotator, "��ͼ��ת");
                    if (_tips == true)
                    {

                        EditorGUILayout.BeginVertical(EditorStyles.helpBox);
                        style.fontSize = 10;
                        style.normal.textColor = new Color(0.5f, 0.5f, 0.5f);
                        GUILayout.Label("*��ͼ��ת��������ͼ����ʡȥ������ͼ�ı䳯��", style);
                        EditorGUILayout.EndVertical();
                    }





                    EditorGUI.indentLevel--;
                }
                EditorGUILayout.EndVertical();

                if (_tips == true)
                {

                    EditorGUILayout.BeginVertical(EditorStyles.helpBox);
                    style.fontSize = 10;
                    style.normal.textColor = new Color(0.5f, 0.5f, 0.5f);
                    GUILayout.Label("*չ������Զ���ͼ������һЩ���ã�����ͨ��ѡ����ת", style);
                    EditorGUILayout.EndVertical();
                }

                m_MaterialEditor.TextureScaleOffsetProperty(Tex);

            
                GUILayout.Space(5);

                m_MaterialEditor.ShaderProperty(TexAlpha, "��ͼ͸����");
                GUILayout.Space(5);

            }

        }


        void Logogui(Material material)
        {

            m_MaterialEditor.TexturePropertySingleLine(new GUIContent("��ͼ"), Logo);

            if (Logo.textureValue != null)
            {

                EditorGUILayout.BeginVertical(EditorStyles.helpBox);
                _Logoxx = Foldouts(_Logoxx, "��ͼ����");

                if (_Logoxx)
                {
                    EditorGUI.indentLevel++;




                    m_MaterialEditor.ShaderProperty(LogoAR, "ʹ��Rͨ��");
                    if (_tips == true)
                    {

                        EditorGUILayout.BeginVertical(EditorStyles.helpBox);
                        style.fontSize = 10;
                        style.normal.textColor = new Color(0.5f, 0.5f, 0.5f);
                        GUILayout.Label("*��ѡʹ��Rͨ����Ϊ͸��ͨ��ͨ��������ѡʹ��Aͨ����Ϊ͸��ͨ��", style);
                        EditorGUILayout.EndVertical();
                    }





                    EditorGUI.indentLevel--;
                }
                EditorGUILayout.EndVertical();

                if (_tips == true)
                {

                    EditorGUILayout.BeginVertical(EditorStyles.helpBox);
                    style.fontSize = 10;
                    style.normal.textColor = new Color(0.5f, 0.5f, 0.5f);
                    GUILayout.Label("*չ������Զ���ͼ������һЩ���ã�����ͨ��ѡ��", style);
                    EditorGUILayout.EndVertical();
                }

         


                m_MaterialEditor.TextureScaleOffsetProperty(Logo);
                GUILayout.Space(5);
                m_MaterialEditor.ShaderProperty(LogoAlpha, "��ͼ͸����");
                GUILayout.Space(5);
            }


        }


        void Base(Material material)

        {
    
           
          





          







            EditorGUILayout.BeginVertical(EditorStyles.helpBox);

            EditorGUILayout.BeginHorizontal();


            EditorGUILayout.PrefixLabel("������ѧ��ģʽ");
            if (_tips == false)
            {
                if (GUILayout.Button("�ѹر�", shortButtonStyle))
                {
                    _tips = true;

                }
            }
            else

            {
                if (GUILayout.Button("�ѿ���", shortButtonStyle))
                {
                    _tips = false;

                }
            }

            EditorGUILayout.EndHorizontal();

            if (_tips == true)
            {

                EditorGUILayout.BeginVertical(EditorStyles.helpBox);
                style.fontSize = 10;
                style.normal.textColor = new Color(0.5f, 0.5f, 0.5f);
                GUILayout.Label("*���������ʾÿһ����������ϸ������Ϣ���ʺ���ʹ�ò��ʵĳ�ѧ��", style);
                EditorGUILayout.EndVertical();
            }
            EditorGUILayout.EndVertical();
            GUILayout.Space(5);
        }


        void Thanks(Material material)

        {

            style.fontSize = 12;
            style.normal.textColor = new Color(0.5f, 0.5f, 0.5f);
            style.wordWrap = true;


            EditorGUILayout.BeginVertical(EditorStyles.helpBox);
           
            GUILayout.Label("MainAlpha��Ӧ��͸����", style);
        GUILayout.Space(5);
        GUILayout.Label("BlurFactor��Ӧ����ģ��ǿ��", style);
        GUILayout.Space(5);
        GUILayout.Label("LineUVScale��ӦUV����ǿ��", style);
        GUILayout.Space(5);
        GUILayout.Label("Chromatic��Ӧɫɢǿ��", style);
        GUILayout.Space(5);
        GUILayout.Label("Frequency��Ӧ��Ƶ", style);
        GUILayout.Space(5);
        GUILayout.Label("Amplitude��Ӧ���", style);
        GUILayout.Space(5);
        GUILayout.Label("VignettePower��Ӧ�ڽǿ��", style);
        GUILayout.Space(5);
        GUILayout.Label("VignetteScale��Ӧ�ڽ�ǿ��", style);
        GUILayout.Space(5);
        EditorGUILayout.EndVertical();
        GUILayout.Label(" ���������������˻���è��������ӭʹ�ã��ر��л�������˰�������", style);
        GUILayout.Space(5);
        }

    }

