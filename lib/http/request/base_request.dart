enum HttpMethod {
  get,
  post,
  put,
  delete,
  patch,
}

abstract class BaseRequest {
    // curl -X get hhtp://localhost:8080/api/v1/user?params=11
    var pathParams = '';
    var useHttps = true;
    String authority(){
        return 'api.devio.org'
    }
    HttpMethod httpMethod();
    String path();
    String url(){
        Uri uri;
        var pathStr = path();
        // 拼接path参数
        if(pathParams.isNotEmpty){
            if(pathStr.endsWith('/')){
                pathStr = '${path()}$pathParams';
            }else{
                pathStr = '${path()}/$pathParams';
            }
        }
        // http和https转换
        if(useHttps){
            uri = Uri.https(authority(), pathStr, pathParams);
        }else{
            uri = Uri.http(authority(), pathStr, pathParams);
        }
        print('url: ${uri.toString()}');
        return uri.toString();
    }

    bool needLogin();
    Map<String, String> params = {};
    // 添加参数
    BaseRequest add(String key, String value){
        params[key] = value.toString();
        return this;
    }
    Map<String, dynamic> headers = {};
    // 添加头信息
    BaseRequest addHeader(String key, object value){
        params[key] = value.toString();
        return this;
    }
    
}