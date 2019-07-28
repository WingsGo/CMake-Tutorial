#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --prefix=dir      directory in which to install
  --include-subdir  include the Tutorial-1.0.1-Linux subdirectory
  --exclude-subdir  exclude the Tutorial-1.0.1-Linux subdirectory
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "Tutorial Installer Version: 1.0.1, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage 
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version 
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
This is the open source License.txt file introduced in
CMake/Tutorial/Step7...

____cpack__here_doc____
    echo
    echo "Do you accept the license? [yN]: "
    read line leftover
    case ${line} in
      y* | Y*)
        cpack_license_accepted=TRUE;;
      *)
        echo "License not accepted. Exiting ..."
        exit 1;;
    esac
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the Tutorial will be installed in:"
    echo "  \"${toplevel}/Tutorial-1.0.1-Linux\""
    echo "Do you want to include the subdirectory Tutorial-1.0.1-Linux?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/Tutorial-1.0.1-Linux"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

tail $use_new_tail_syntax +144 "$0" | gunzip | (cd "${toplevel}" && tar xf -) || cpack_echo_exit "Problem unpacking the Tutorial-1.0.1-Linux"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;

� N�=] �}|�ŵ�﷛d7!	$�( $ټxC��$ ������>��}��� U���Z��K��}�*>jm{/>�j�������W/��Զ������v��]�޶�����̜9s�̙�33g~�_0�[�������ٳ�]�kӡ�8]�����uM��&g���嚭8�ނ�I����-����D��_�����Jw�y2�I"�x��o[飩�!W��j(�ۿ��av]#�cc}���ۊ���'o�I�1O���g�S;$\���o�S���?�m\�QO��=�!~^,��Uj��O��ե�gvMO4Z�)*���̑K^t<<. ��v.����UY��YtS;,n���J���}�����xgxY���+����#�w�9"����A��8��K�3��n�-�W)PΤ�q�򬿚C�|ˌ�_0���c�p�o�3(_̳�؋�-��@�3���=�"-�������/Hp䉘 y
��7�����O~qղ��ʿ v�+W��,�V�P2H���\�O�2uJ��a�ұ�e�����sU�}ް��ԑTϹ��*}��@%a���#X@ԥ:�m�2l�"�F��A�J�hɣ�H����U".������W�R\����͕7-%tI�"��i�$ygBfѲ94�)WA�V�/-�_��_�鏄|5ldj����D$ZӓLDbw�&c(5�x�&��^_�gƌ��L���&��aV0N��'MMo ?!�(C�`\����	�}���w@{}~��s�#߂�d ��/*(��ʰ�?��f����p���5�38�r)m��9�͘�r9��k�u���ڦڹ�Y�D2�[���bEa�Rmf558g�9g�ZH�ἳ�d�=[gEc���C
�����wBK(�H�7� #�x�/��:=�4+$��1�@A�x$��D	nJ.U�t��T��H�[}��J�,��7�g��FՅ��T�e�J�i��D�}�fh/?Ei[�l�sں�d8�7�)�1�NWSumC��5�Ԣ���-��kuС�-���P�����ZR�Բ���\"�1�1��W��X�4kV��5~�ٖ��x[|v���df������ρ/�#��HӃn�f�G6&C�<w�����b�C����@�Q�b���eF�x�	�[�>ʄϓ�*�W�L�gz}zk�M�JY�l0�H���	�g2~�	�W�/2����&�����%��	���f�wI��a�o���Lx���	�C�?b��HƟ4�/��L���?o�/㯚�g�r_7�ߕ�?��ߗ����.�������Q��3}~>N	-&�R�J�{	&b�롘/�N�J�םp+ս�������"���ޘo #�s��|�Yh���Y���	�|49T�in���vϕ2��_���!��?}�R'&|�����2�~���OT��J!��cZ�O�x�e���\�L����oʂK�_cJ4Ӻ����\���T��2��Ks��D�ii����!�5��ʹ]Jv��e��ve����o��W�@��o(�,��	:>)y��y��?�Q�w�ȿI�&ޜ�����g_z��Mj���������J��EÕ��ü�mUu���U�,6��<-����)�R~a�����Sw���~z��'��u�O���������^e��s��lW��6��m��������?�1�B-�������o��4ӌQH���I���O�k6<���u��f�c�)s�a�ci΀�~_��sb�ל?+���5��N#d=$�J�d��R����,2�]n��[2�)�S����ɷG�K�-��%�O׫	/�G���Ȱ��)�:M��P>���x���Y+�˥�J}�%��84jj�	z��Pxߪ��:��!iiS����Rf�z�zza���G������=Us�lI�񻋐V�����:7\�>��q�>�c��g;G�-^v������I6=8��'��c���W�����N�Ws��:�O����??�L�1ʞ�-������>i'�' �[L���.����;��x��1}�	��P$��('4M�Vhk}}�x�[t�㴥�:zVj^_L�{V.F¾7���=e��Ĝ@$���㾆�p ��j`|$o�Z��;ҭ��;��{����������x���u-��C��Eh�s�:z��Z���I�V�2QFw"�89v�b֨u���x"Ʉ!e �
	U����]s�A��N�	�T�l�Dį���@8�'KՆ܁���ٱt�VW]W�(�6h��h1�-�j��xA��q�����8J�	b��!�7I�f�#�ۣ����(I��.�K�����悲4��O�O��VJz����w���=������Mm>���Iç�N�������4|���+�v��lHç{x����=��i�t�o��o�ۯ����T�?�p"�Џ����H?��%��G�>��B��#���p�Nyq�����-�h��s�W������!����"����G�*���w�؇��q����q��p�oG;���?��~�E�������9���~����x���4��?�H3�'�+lVͦ|��H�񃗑�ֵ�B�j��hi��WƲC�*����Lė0���%�?����w�����8+�}���C����?�Qb��m��m�D�#�ߵP�;i����P������Q��?pI)�l�����g0�=2{z���)�<��ݽ����ɗ/��z��+[_n�Ri��}.�Ч?:v���P��'%A�"bC�2e#"�Ly�C���#�E)"�[���ۙ��FS�qNiG>����a�Г�ROFuC
�����d��u���3B�ѹYQ���A��}��v'�^��5yڧw=v��6ᡛ�ZGr~w�jy ч0rn��} �A�CwC��s�ˇiu�G���^r��Kv[�nIO��Sn�8��u����v�~�s��<���z���k��[	��=���;w��B������j��7��c@��yɦ%����D;�'U��1,��
��\����S�Vz�}��yIw��E"	g������_�k���#�������QM&���e�R�eA'A�7�r��˥�~fgs ���.�}z���u�7Y�_Ƞ�:��V�>l�}��x����'��H��'��/rȳ@�/�0��������og�H�&ߣ�Q��]��/���)=�Y#�~�#�g|i��Z����k���Ϋ�N�*����҂��9�V�6�J�,)�]R:mi���~i���PL��%>�|[�g?�9<�	�G����sԡK͌7ˀ>��	>�s�ܧ�go�>B?���1���>O�#���1v��~��+O����i�����(���N���ꏱ͓��vS��Oq+��4g��ɸ.w������O���i���d\�㈌�����G�ǚ��r��$�r	�K�p@�K%�I���	�o����z]����s�3�ԬeH��Suz�줹<�ߘ�zc�紊̻���][��,�/Z���j�USG��vl���Eԍ�y�zF����%��H޴e�/_Y��=�i,eɻGȖ�GS�`��2��T`ߧ0��/K	���k�E�
)�|��kH-�W�w�;!�2�,��-��R�Gv��;/��Q�ya�}^�z�il�>@����R�!�s�X|�psa>x**"텇h���*���U`�Ȇ�I��<u�qK�M4
����H�+���6ZX�R�9�(�#ո�Tũ�`�k�#���U�{0R�!pQ�����+��Ņ�@�Ju#E./<��$��{
O#�U0]�|�����9���+�`G�Z8)39��p)"�*އx��]�;5,�Å��.u����)3��Pd�u��|'�wX�m��`���k۰����Bi�MHU��R�l=��B�ܶy���M|K�Sx�5�L��#L��>z:��4�k��^�/�? A��dW,����f�خ 9+�$���Be%�_���y�o�Dx/w��#��C�y��&[�SY����v4�*�t��Њv����|�+��ຠ5�.�B�Fu�H�P��e^���E���H/|�T@���U�"/���!Q�.�B9E�@�_0�&R�A�I9����@_9�I�߆��d4��j�~",���D���	9�Q�@K'�a�F�=1�c�4<�q9x�S�J~��FO����H^@�r�R>M`�5/�yȚ�US��Rh��'���)^����_}�ҫ��o/��&W��5\��=ţ �;���+���೗0�q��`�G�=��fʪ�[�|�,_H0��
��d��'��[_�W |e���d����.g���dp�o��g��U|k�Z|;�
����3��w�b�A�v�?�ࡗ<��Gǌ88��c<�����e�����)��������h*�/d���~r>���e���	�)��/0,T?dX��X�B�1�cU(gL�u%�I����|Se��8��{�[�4����}����Ma�)d�JV�[D�/Y�9B?Nا�������S'>E=�d��=_���z�2�K}�dm=���7�E��N�]%=!�R����H\��I\�F�P�	;��&R6����+	�AO)�H%kk����mF����i���^II7�=�}���K�?�N����]����I�c�$y����e�V��>K�W=BI���ظL�K+ɒ���N�pj�]��ʩ�Ӱ.��\��PgǄ�+f�~�Kn��vR;��qV�U%� -5�}O���)�IV�V����Pf�����m!"����4��9�Fp�&�|��E��G	1�p��e��i� �o|g�0_gaN����w1!����	������)"���)�XZ;jmWǻۇ?��[~E�7؞ۨ�eoB������ľ�K���Q����3|�)e�~g�����2QP� �]���-"���ę�R�,j�EA?G��q�
Tf�A�"�j? ��i��� �T}�z%eE�e	w@���n*�B4"�S	ŤŲ	j�(AsV6V�T��L��0h�,�A���S��-��JQ>��c5�AљyPh��CB �@J�4��樏:����3�ܳ|�R�@=�Td��O.kVqԂ�����ǰ��Q{
&��Y��0�_Ơq�x��5fob0����ߍ����p8���3h����G�d�SZ�g��
�����`�q9�70��`��j���`�C�~`d����'̞H�r9VW<9W�`}QU���Y��>cp�e.��K�ap�v����b'�5�1�v)�=������w0��-�<���?g��?0�u�$��\��1�b��F��ǔ[�o� �S/�X���ЦahW�eX�>ðH-:�����
j;�s�9�7�����0��c�����l�*���38/�T��t�� ��k~����1��v����o3�$o2�g&0�����m�2�z�k�"P���SF/���&��7����p���J]��gL�;����*vW��S��z��Ӆ!��z�L���apa�uWb������𮱽�N�3u_��Y�>�f�#�n�+FVrEݳ(@�����T������6DH�]�*�����0�����OV�"fq���f��GT����v���V���/�!;a\�.�P1��M�W��E2)˓L\����/��Gl���<l���&�P^�jEdW_"5DI�M�Pqj�Y5LYf�B�+ܖZ���CDR�k�����͖��!�"\C�'|���#���r��:Z̸ʼ�${�2�K���G2T,Wwc6Q(o���Q*:�2�Nx$;E,oA�oP�X-b��GT�c�V�~�s.�xJ��"�<��p�&b��B�^Sԅ�P�T�eԲ�MО+�y�>R�Q�»����:������:.���d�y�c���"�~�4U�C�V,|��d��yW���FE�Q�D�\q��/��%�G!�e�oE�[D,o�i���2o$���Q�.pG�J�~�����	�Rq�@Y�'T<(bya��{"b_�#Ŋ"�o�N$b�y���O�/p!��>��iuU뤞�O2�T�\����W�xN�,JU��1�+��ɠ�w3��~�1�!��) �
�S����2/z����h�m@_n���z�����`�v62W�0K�c����~Jѥ�S[ZV8p�6�Ö�E�M֋��/bTV�rU��-�*��Kcx�䪱31wW���2e���6�����{����ON�Lb����j�q���z3)k\3����b�B��9����.b���[�s/�?<��OG��>�P�_)��2��J.�ޕ��J�-!Y�.&�����8��h�l[�}Rĸ�!�E���a��ᰛ9$��u�û��n�j��HC�;�j�`n��뭶��1�Q��$�氏9<ceg�8̜bp�`n�(�p�MdnW*��������HMk��0ޖ��:����#yUt\��˹�4��loZ��%��Q
�p�lEO-�#��ӳ�T�����d=l�1#xʑ&�Z.B�Ê�K�]:*Ţ��ж<I�Ӷ��~�@
yu-�:N��H�V�eG�NN�gNkB��b�0�\������cҠ�v���6�#V�(��I�HPE�
^�i�DAv��
"�����'��}��t\8�^ ض����"��̯CzՊ�+�$���Tc-�i�f�R7��w9��Rn4����c�d��ɔ�dt��[��>�f�H�n9�$���+��3մ,T-�C��Ña�N]	f"xR�t���-��Wd&�!�q��$*�d��}T?�P'��KV��C���r�����q�6Z� R�|JOYn7�	�Q�ܾAA�1�њ���34�6Z�tn�P� Gz�IY{"����7��˄Wx�񗳣�~-ٌ��ۯ����b�K4��_ɞW;�F{�U<������F��� ����q����;�s㯇u�f�f��7���*�(���K�`;�5��ot�E�޷�&�fJ[��؟U���"y:�^d̒�eg�s��V�ʡ���-� �2遪L�/#��W1���HB��ĖE��c��{�-� �xdp�I(үD�/T�^�T��h�Gg���9gc���6�$O@��c�(�Y��z?��#y�*-���{���Zm郅�d������:�5��v��ϣR�8�N���J���M<����jX��0za
�Q��
~�8[Om�
�U� {����(o��_���2?���\ �ۙ�g΅� @���[��)h�'*��Mo ��Ȼ�&ƖW@���yC���=o��(}a���-|��
�=^�NF��_�j�+�9���q��W`����G����#�z���MT�c6<f��9���]a�sh����+0pY���v1���\89�\Fl&��'�f�(<���Y�v,峌�@��'��?���$;A��|A����	�U�g����NR䄍���	���2^6s��@�����1_��'�Ch�������/��&l�l_B�|�:i�M������hq|ς��7c�~���F���O~��[��&��O�'NI_'�Ml����'M\.NI#�o���!�.NI���!NI_C���v�=�OI�k��;����U��W�p���Bx��V���.����#}N\�p��g��A��^�z���w�y�����oQ�'�������Fx��n�{>����!��^|�g���0���O��J۷��M����L�1?(+_م�OD��w�2�g�(-c�ll� ~��L�f����-  �m_����l��D9m�y(��BV�h�&��=��j�\�;�U�-�:P���^d5vKE�V>�7�%6~�,�1�y��l�E��p¹W���Gi�
N���_=�43���<��	hZY*-�#a�ܜ��,�]���}`�ː�p��XSUN���(�_~���%�nExP�s��O|�"��KP�[���^!}ҿ�z��J���k(�{R�,�-���s��M2T�9�����yڼ�b>�n��t��m���Y���8mG���ފ�FQmQ�� ��&>^+z&�H������Q�)�����1SL�L�z��\�<k��!E����������I-W�T{״/�����_���mY�|~}���6���#Y�_Ma�!��'0��:����ޖ/"[��4<�B�����H���tE�D�ͥ����-7����8����;2��t�0(�ņwX�H��H?�+p���U�
�E#j���|��{�r��=�|)4=��-��b'��g��������o��*m_���{y�=�@��ƹ�	�34�u%����(��	��T�t�(��Z����HM��`�<|Im�u��ݒ�**3� WNӴ�+��qe�A�Lj�9��$����8��Y�m�D��F>x��.�6��R�j����Hy�S�~�_!�T��`t'��4�,h����@����I��
�x�C�/-�	,�m��gr&�u]=��d�nK� �=�E�_Y�-R�����E�'��~�N	���-�W�?jO��8��w����͕����M,�>&�;�0Go�M���Ĩ
�������y�r��>�H���5{�X��7��W���A떐P��OQp�hx6��QRv���)4�B�=	[*���<�ԧ�]x6�+���s�9��B.
υ��a�;�x_�!��_1�E�:k�c�s�1xD�cL�~��i���l�E7�x��&^w����l�}��cx��&^����M��b��vT7���H�ao�l�0n���jї+��0f����0�~!�5ugX^�ΰ��$ @e�ZK��/���Y���h�HU��KA<�BM�,.I+�DU;F[:I�Y�3���}g��|-YY�qx�m�(#G����
�Q��bt��i���*S��Uٍ���UjcӯRgɨ���k�Ty��\���@�����"�i�kM�'�����S2�S	�M�˟�-�1�W�MMi{q�Ր6��i�G��>Rѫ�(�gV��`�=U gt�)�jER���U�騧Ε-J��<�r�H]Ϯi$��� �z�j� ��F4�(��h��:�?;�E�礗���ܡh2H��UG"�O�ȵ@v���!�$�"Ru)T�X&�4�F{ټ%:�/M�Q�e��G�4%��s8��x���ь:a;1��zt��s��!���X�Υ2��(@��
3�j�g�t�$�5)�ej���M�θr)d�u<.�iȈ��&]4Te�X_�d�hW�`���W5p�����mD ���l��I��m�Aj�sd����ϥ�՘��q��\��Eܠ����M�Q�>�[�IN@ߞ�ȓ��1����P�p��?�/�ȿU�K����?�Zۣ���
�Ё��/|��6���jm�q�d���H�M�D�Δ:���Tߠ��}sZ4��̋)�"��C[d��Q
-;��W愰�:!2O0�q}B��@�k�=���4_,a9������yP�L�o�"��HA��ϫE��İo���,�\�"�N�p�eJ0�%!�P��P�Ea��L�"1����@�Ԣ��������a�}�ꑖ�F���o�Ԍ<��9Œ���,��=4��?�`����'ז���Eeڵ�}��/<�$�e4�;�p5i��T�# ��'�Q�{��]�G�M�D;��$�Aj���?R�n�)��m�b^�@W��#�^����ޤ_�:Vk�!���/1 T_T���Sb�Pd�';����Q%Ҷ{��9'�s9����?Nw�2�G���ߣ$��:{��I��-�?���Kv�)��/�b���p��������q�L�Z�)��b@ʀ[���e�FM˨��>#��掶���ՔD��|̍[P�F�b��O�ɸr}@��(4��¡�Wf#b\�����}�Ts�i�
7K�KZ���X-1��I��o�'W9W��K�U|�l@*Ɠ��|a�v-�=�^!wl�/W(�7��Sy�%��.�@3v�iܱ�����Q3E#|S�P
l�;a�((�ꠂQ�\C�u��i�4n|_�#�J�­d�A�H��~������VI�i<y0<��`����g�W^�0���Ñ�����f�N�b[cj�U�ƅ�����@�HY=<�|4'y":SuP�����,��yCj��7	�t&bIߢy�x\�p��W�b���� ��2$܄I�7�KB�0D���{q��J���W+s_�YQhr��	��F�CѨ�Q�`2V��$��[Ft=�3��%�;C�70�J�r��s^�L�J���e��1ڇHβR�.H��x��E��AxQzk���z<�V�{n2�v�����`�L	��ٖڋz������Z�����4I9b�%�ڎ�i������2�8�8��t��ȓ�̀";Y�@�����~D��z�3Ƕ+��^8ߧE�8@��`h���C�k<�4����m�^�C�7��}ᄫ�5�Oρ<4���D}��A�F,@6�}��&���}��1���+��+��#m-򈔖p�%�տ-@�n�9�'lX�@_?wT� ۄ}��.�V2.w��5S؂4�%��s��HI$<��������C��.�D$ݶ@�'�L,�Ih���qO��tӶ��K�t�1K�j�R��S���ôn�ѹ�I�=��R��H�w���0�.f��IX�����ְ�lG�	�|<�2�6�i.s�S/��3G��OTy���KF�5���zVl�7���v��4���[�]�z��5DI'5yt��Q /�D��F�'�-np�D07q}�<A��j�A)$���nĲ1*��[Û�Ёۋ�V}�H2J=^����3o�Xb����j1�mHP�~��q�x�>����g�h�%�u��`L��85S���'7����y.�J��ٚ��>��/ς�Z_$��߸'@�,�xR�E�H��u	P��>��a�㚘�2��o}��h�{b���Q�_�����C}����l����	E�2~�ٟ�2�u=�31T�( �O#��sܥk�3�7��nۙ=���0fm[ ѯ�9�g����vy�����*�5-/�H|ct�`��BKэ�5����@x"�(M���H����zcb�=�B����`E�ʶ�/��Ӑ��X����2�
'����.����>�Q/��l��;/c�l�{s�������������[� ].�f�b����;2��%D�\qD�1v�޷��'f�x,�;��#�����bV��N�B����}��Y���垲�&⯲��<�!M{wl;u|}N	~��rXd��V�&'<�Rf����K���aL��ئ���A;/�lո-�;5tyB��֥+^lި���f8�'D/׭'����|,��^/�����ʘ{���(A���i�2a1���`I��c�4����� ���-�4�U̧^�hol�I/�Zx���
�	W�֜1�f�^z9���ž>�-�HA'
��vi'�Mb�IM2Wk��d�0Ʊ֠���.9,�E#��i�OIyBDCx���9�����IƄ.�.�e2m�lԍb4�m�f�M�	S���b�!b/o�z���X�
l��7P//YO��֞�֓�c�b�0Eة3;(��J,AU��\?a4��Hq��M�� e��2Ӄu&E�	Ľq���$�_W�P�}&��f1�X�h=�5�����bLݲO�Th�2V�T��UЯ�g�!��8ޞ!]e�N��s�\\�]� �؝����W[�\��,-���$c�M����P���Nl�` N��ݗKmbs(��w����
�����{<#�r�N���h�{���_���k��΋S�)��姱r������?�Ɣ~�u&�b����*���<��L|�q�Y&���'-o�z��I՜_h�o��/2�A��3���+�,��TOgŗ��g���e���Y�eƽٙ�Jsq6�H㾺L|�qO]&~���8��Gg�WͪT��f�+�{�2�UJ4+>u�r&~����ˁ�?!~b�s�پ��t�Eo����t/�X��2�%�|�a���o���usxh;�/��7����/��]L�P��r ��$��\�[�vU��o-�S���K��8��~��$�^���Wr�ig��������~{ӏ��$ެ�����r��E���帧�[��v�r��9�fxݞ�w�>�f�7����?���ڟC9�)�d�ϴy��(.�A�Œ�>��X����|�ˁ?jA��g��۬��O�hY�oՔY��إy�������&�sd{5Ky�����ܡvo�*���2��[��w�5���/�z���W>����e�/�B�O����'˼�%≤�_�����j��=���.��h����pjy#Z_0�K�[/�`�;9Ȟ��/��V�n�ې�H��]��C1�v�&�Z�7�4o2�E��c�Yi��tcw��57�G����\'���Pd���|풕�Z�|4�����V��Z�%A{�Z����˻[{��%K;[5y0fTϛ��K���UKVv,K]��ܜ~o��a�O�ZO�c�?��o��~�,��Ͻ�M�&��<�>�`*�8_Z�����c}��\�j��5�3��=�E�F�4����W�ӏ�S%z����L�0���_�0���g�2��3a�d?w��G��2*��di�,l E�vi�b��*�w���j��0�߆Dʀ�V<#���oJn�P4�@��G��"���QP��OX������TLd�L����zb,�;�(`+JJ���K�G/s"3��0��֩���uG�{F"n^��o*Ɵ<�����C��AN}�)�2����	��|��X7�{�XDϯ�7��"5H�~����q綞_ߗ>-�e�q���_�{�"�������]R�M
3��Eܩ�������E�z�u�-&�[!?J˯e�-JJ~�2���G������d~�^p����_"�/�q}}H���%ϗy���Qҿ��������\�o]���cRϯ�����M���)���Z�7���Ք__��,	f�$��}�;L��u���"�B���_S2ǯ�~X�>A�{L�S���N�9�C����Y^��c��f�a������ɧ��%�f}��?���������ђ����H������4;�9���[�.���];�f?�����k*_��~��u��Y~} �� �QS~}ud�iί?)����!�dF������VU���Y=��[��	�Cm*�o��[r�ן�9�gz���?-G�?ʏ�~d�֭��1G�w�ce�i��i���߂e��2o�_�o�~�O���_�c?�i>[���`���ԟ�7n�z<������|�?��{��1��;{v�'���G<z��_��?��>�������_W�ҿ�[W_��o�mr}����s���4�����ֵ��Wi+��X���*�Mб�j�uݭ�ʳV.�i/�9�yj2���%�[���m��k���]���V�?�������-������Ʀ�ںz���]�|�����;�ߧN���XU_7��T�3Ku�ڞ�Umrxs�S&;[Z�uvw�.s�=�x����NK,���`�w2Y�T��7�/:9�55�p$���͑mq�����u}~�љ�w^P$^,I�4��>�h�'f������o��\ �  