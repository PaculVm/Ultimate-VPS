
fun_transpy () {
source=pt
target="${SCPdir}/idioma"
if [[ -e /usr/bin/python3 ]]; then
PY="/usr/bin/python3"
elif [[ -e /bin/python3 ]]; then
PY="/bin/python"
else
echo error
exit 1
fi
$PY -x << PYTHON
# -*- coding: utf-8 -*-
import requests, sys
def traduccion(source, target, text):
    data = {'sl': source, 'tl': target, 'q': text}
    headers = {"Charset":"UTF-8","User-Agent":"AndroidTranslate/5.3.0.RC02.130475354-53000263 5.1 phone TRANSLATE_OPM5_TEST_1"}
    url = "https://translate.google.com/translate_a/single?client=at&dt=t&dt=ld&dt=qca&dt=rm&dt=bd&dj=1&hl=es-ES&ie=UTF-8&oe=UTF-8&inputm=2&otf=2&iid=1dd3b944-fa62-4b55-b330-74909a99969e"
    response = requests.post(url, data=data, headers=headers)
    if response.status_code == 200:
        jso=response.json()['sentences']
        for x in jso:
            print (x['trans'])
            return x['trans']
    else:
        return "Ocurrió un error"
def main():
    return traduccion('$source','$target',"$@")
if __name__ == '__main__':
    main()
PYTHON
}
