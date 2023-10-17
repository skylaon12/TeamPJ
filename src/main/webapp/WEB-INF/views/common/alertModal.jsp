<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div class="modal fade" id="alertModal" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<div class="modal-content">
				<div  id="checkType1" class="modal-header panel-heading">
					<h4 class="modal-title">메세지 확인</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body d-flex justify-content-center">
					<div id="messageType" class="modal-content panel-info">
						<div class="modal-body">
							<p id="checkMessage"></p>
						</div>
					</div>
				</div>
				<div class="modal-footer d-flex justify-content-center">
					<button type="button" class="btn  btn-sm btn-danger" data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="successModal" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<div class="modal-content">
				<div  id="checkType" class="modal-header panel-heading">
					<h4 class="modal-title">${msgType}</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body d-flex justify-content-center">
					<div id="messageType" class="modal-content panel-info">
						<div class="modal-body">
							<p id="checkMessage" style="color: black">${msg}</p>
						</div>
					</div>
				</div>
				<div class="modal-footer d-flex justify-content-center">
					<button type="button" class="btn  btn-sm btn-danger" data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>