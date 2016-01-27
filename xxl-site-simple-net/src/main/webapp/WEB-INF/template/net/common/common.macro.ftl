<#macro common_hosturl>
	<#if request.contextPath?exists && request.contextPath?length gt 0 >
		<#assign host_url = request.contextPath>
	</#if>
	<script type="text/javascript">
		var base_url = "${host_url}";
	</script>
</#macro>

<#macro common_style>
<!-- jquery -->
<script type="text/javascript" src="${host_url}/static/plugin/jquery/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="${host_url}/static/plugin/jquery/jquery.validate.min.js"></script>
<script type="text/javascript" src="${host_url}/static/plugin/jquery/jquery.cookie.js"></script>

<!-- bootstrap -->
<link rel="stylesheet" href="${host_url}/static/plugin/bootstrap-3.3.4/css/bootstrap.min.css" >
<!--	<link rel="stylesheet" href="${host_url}/static/plugin/bootstrap-3.3.4/static/css/bootstrap-theme.min.css" >	-->
<!-- HTML5 Shim 和 Respond.js 用于让 IE8 支持 HTML5元素和媒体查询 -->
<!-- 注意： 如果通过 file://  引入 Respond.js 文件，则该文件无法起效果 -->
<!--[if lt IE 9]>
   <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
   <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
<![endif]-->
<script type="text/javascript" src="${host_url}/static/plugin/bootstrap-3.3.4/js/bootstrap.min.js"></script>

<!-- scrollup -->
<link rel="stylesheet" href="${host_url}/static/plugin/jquery/scrollup/image.css" >
<script type="text/javascript" src="${host_url}/static/plugin/jquery/scrollup/jquery.scrollUp.min.js"></script>

<!-- net -->
<link rel="stylesheet" href="${host_url}/static/css/net.1.css" >
<script type="text/javascript" src="${host_url}/static/js/net.1.js"></script>

<!-- navigator -->
<script type="text/javascript" src="${host_url}/static/js/common/navigator.check.1.js"></script>
</#macro>

<#macro header>
<!-- header导航栏default  -->
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	<div class="container">
		<!-- 折叠 -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#net-navbar-collapse">
				<span class="sr-only"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
	      	</button>
			<a class="navbar-brand" href="${host_url}" ><span class="glyphicon glyphicon-home"></span></a>
		</div>
		<!-- 响应式特性 -->
		<div class="collapse navbar-collapse" id="net-navbar-collapse">
			<!-- 左对齐 -->
			<ul class="nav navbar-nav navbar-left active-nav" >
				
				<#if articleModule?exists>
				<#list articleModule as module>
					<#if module.children?exists>
					<#list module.children as group>
					<#if group_index = 0>
					<li class="nav-click" ><a href="${host_url}article/group/${group.menuId}.html" >${module.name}</a></li>
					</#if>
					</#list>
					</#if>
				</#list>
				</#if>
				<li class="nav-click" ><a href="${host_url}wall/" >一面墙</a></li>
			</ul>
			<!--右对齐-->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown login-false">
				    <a href="#" class="dropdown-toggle" data-toggle="dropdown">个人中心<b class="caret"></b></a>
				    <ul class="dropdown-menu">
				       <li><a href="#" data-toggle="modal" data-target="#loginModal" >登陆</a></li>
				       <li class="divider"></li>
				       <li><a href="#" data-toggle="modal" data-target="#regModal" >注册</a></li>
				    </ul>
				</li>
				<li class="dropdown login-true">
				    <a href="#" class="dropdown-toggle loginEmail" data-toggle="dropdown">小窝 <b class="caret"></b></a>
				    <ul class="dropdown-menu">
				       <li><a href="javascript:;" class="logout" >注销登陆</a></li>
				    </ul>
				</li>
			</ul>
	   </div>
	</div>
</nav>

<!-- 登陆.模态框 -->
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<!--	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>	-->
            	<h4 class="modal-title" id="loginModalLabel">用户登陆</h4>
         	</div>
         	<div class="modal-body">
				<form class="form-horizontal" role="form" id="loginForm">
					<div class="form-group">
						<label for="firstname" class="col-sm-2 control-label">邮箱</label>
						<div class="col-sm-10"><input type="text" class="form-control" name="email" placeholder="请输入邮箱" minlength="6" maxlength="18" ></div>
					</div>
					<div class="form-group">
						<label for="lastname" class="col-sm-2 control-label">密码</label>
						<div class="col-sm-10"><input type="password" class="form-control" name="password" placeholder="请输入密码" minlength="6" maxlength="18" ></div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button type="submit" class="btn btn-primary"  >登陆</button>
							<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
							<label><a href="${host_url}/safe/emailFindPwd.html">忘记密码</a></label>
						</div>
					</div>
				</form>
         	</div>
		</div>
	</div>
</div>

<!-- 注册.模态框 -->
<div class="modal fade" id="regModal" tabindex="-1" role="dialog"  aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
            	<h4 class="modal-title" >用户注册</h4>
         	</div>
         	<div class="modal-body">
				<form class="form-horizontal" role="form" id="regForm">
					<div class="form-group">
						<label for="firstname" class="col-sm-2 control-label">邮箱</label>
						<div class="col-sm-10"><input type="text" class="form-control" name="email" placeholder="请输入邮箱" maxlength="50" ></div>
					</div>
					<div class="form-group">
						<label for="lastname" class="col-sm-2 control-label">密码</label>
						<div class="col-sm-10"><input type="password" class="form-control" name="password" placeholder="请输入密码" minlength="6" maxlength="18" ></div>
					</div>
					<div class="form-group">
						<label for="lastname" class="col-sm-2 control-label">确认</label>
						<div class="col-sm-10"><input type="password" class="form-control" name="rePassword" placeholder="请输入密码" minlength="6" maxlength="18" ></div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button type="submit" class="btn btn-primary"  >注册</button>
							<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						</div>
					</div>
				</form>
         	</div>
		</div>
	</div>
</div>

<!-- 通用提示框.模态框Modal -->
<div class="modal fade" id="comAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<!--	<div class="modal-header"><h4 class="modal-title"><strong>提示:</strong></h4></div>	-->
         	<div class="modal-body"><div class="alert alert-success"></div></div>
         	<div class="modal-footer">
         		<div class="text-center" >
            		<button type="button" class="btn btn-default" data-dismiss="modal" >确认</button>
            	</div>
         	</div>
		</div>
	</div>
</div>
</#macro>

<#macro footer>
<footer class="footer">
	<!-- footerlinks -->
	<section class="footerlinks">
		<div class="container">
			<div class="info">
				<ul>
					<li><b>关于:</b></li>
	          		<li><a href="#">5i我爱</a></li>
			    	<li><a href="#">在线反馈</a></li>
			   		<li><a href="#">用户协议</a></li>
			        <li><a href="#">隐私政策</a></li>
	        	</ul>
	      	</div>
	    </div>
	</section>
	<!-- copyrightbottom -->
	<section class="copyrightbottom">
		<div class="container">
			<div class="info">《5i我爱》所有内容来源自网络和网友提供。如站内内容涉及版权、著作权等问题,请您联系管理员进行处理。</div>
			<div class="info">Copyright © 2015 XXL</div>
		</div>
	</section>
</footer>
</#macro>

<#macro tips>
<div class="panel-group" id="accordion">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title"><a data-toggle="collapse" data-parent="#accordion" href="#collapse1">欢迎来到“我爱”</a></h4>
	    </div>
	    <div id="collapse1" class="panel-collapse collapse in">
			<div class="panel-body">“我爱”是一个原创分享糗事的平台，遵循UGC原则，网友可以自由投稿、投票、评论、审核内容，并与其它网友互动。糗事内容真实，文字简洁、清晰、口语化，适合随时随地观看，缓解生活压力。</div>
	    </div>
	</div>
</div>
</#macro>
