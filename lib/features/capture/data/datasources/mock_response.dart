class MockResponse {
  /// DMSSamplingOutletScoreImageTemplateGarniture
  static final getImageTemplateGarniture = '''
  {
    "StatusCode": 1,
    "Data": [
        {
            "ImageGarnitureId": "4b0e047b-63fa-4592-9842-05cbc5dc83c2",
            "PlanogramId": 58,
            "PlanogramCode": "1-56WF7HP_1_1",
            "PromotionCode": "1-56WF7HP",
            "ImageTemplate": "https://xebangphan.vn/wp-content/uploads/2024/06/ha-giang-mua-he-2.jpg",
            "ZoneName": "bo_chinh",
            "Level": 1,
            "Type": "require"
        },
        {
            "ImageGarnitureId": "4b0e047b-63fa-4592-9842-05cbc5dc83c2",
            "PlanogramId": 59,
            "PlanogramCode": "1-56WF7HP_1_2",
            "PromotionCode": "1-56WF7HP",
            "ImageTemplate": "https://xebangphan.vn/wp-content/uploads/2024/06/ha-giang-mua-he-2.jpg",
            "ZoneName": "bo_chinh",
            "Level": 1,
            "Type": "option"
        },
        {
            "ImageGarnitureId": "4b0e047b-63fa-4592-9842-05cbc5dc83c2",
            "PlanogramId": 60,
            "PlanogramCode": "1-56WF7HP_1_3",
            "PromotionCode": "1-56WF7HP",
            "ImageTemplate": "https://xebangphan.vn/wp-content/uploads/2024/06/ha-giang-mua-he-2.jpg",
            "ZoneName": "bo_phu",
            "Level": 1,
            "Type": "require"
        },
        {
            "ImageGarnitureId": "4b0e047b-63fa-4592-9842-05cbc5dc83c2",
            "PlanogramId": 61,
            "PlanogramCode": "1-56WF7HP_1_4",
            "PromotionCode": "1-56WF7HP",
            "ImageTemplate": "https://xebangphan.vn/wp-content/uploads/2024/06/ha-giang-mua-he-2.jpg",
            "ZoneName": "bo_phu",
            "Level": 1,
            "Type": "option"
        }
    ],
    "StatusName": "Thành công",
    "MessageTechnical": null,
    "ErrorMessage": "Thành công"
}
  ''';

  /// DMSSamplingOutletUploadImage
  static final samplingOutletUploadImage = '''
  {
    "StatusCode": 1,
    "Data": {
        "ID": 1,
        "Message": "Thêm mới record thành công.",
        "SystemMessage": "Db_ExecuteStoreSucceed"
    },
    "StatusName": "Thành công",
    "MessageTechnical": null,
    "ErrorMessage": "Thành công"
}
  ''';

  /// DMSSamplingOutletCancelImage
  static final samplingOutletCancelImage = '''
  {
    "StatusCode": 1,
    "Data": {
        "ID": 1,
        "Message": "Thêm mới record thành công.",
        "SystemMessage": "Db_ExecuteStoreSucceed"
    },
    "StatusName": "Thành công",
    "MessageTechnical": null,
    "ErrorMessage": "Thành công"
}
  ''';

  /// DMSSamplingOutletSentApprovalImageGarniture
  static final samplingOutletSentApprovalImageGarniture = '''
  {
    "StatusCode": 1,
    "Data": {
        "ID": 1,
        "Message": "Thêm mới record thành công.",
        "SystemMessage": "Db_ExecuteStoreSucceed"
    },
    "StatusName": "Thành công",
    "MessageTechnical": null,
    "ErrorMessage": "Thành công"
}
  ''';

  /// DMSSamplingOutletConfirmImageGarniture
  static final samplingOutletConfirmImageGarniture = '''
  {
    "StatusCode": 1,
    "Data": {
        "ID": 1,
        "Message": "Xác nhận kết quả thành công.",
        "SystemMessage": "Db_ExecuteStoreSucceed"
    },
    "StatusName": "Thành công",
    "MessageTechnical": null,
    "ErrorMessage": "Thành công"
}
  ''';

  /// DMSSamplingOutletHistoryImageGarniture
  static final samplingOutletHistoryImageGarniture = '''
  {
    "StatusCode": 1,
    "Data": [
      {
        "ImageGarnitureId": "f9b21cb2-b438-43fa-a519-e887de9506ab",
        "StatusId": 100,
        "StatusName": "Từ chối đăng ký",
        "Note": "Lý do: Bộ hình chỉ có 1 tấm hình",
        "CreatedDate": "2024-09-23 08:52:47.037",
        "CreatedByName": "Trang Trade Visibility"
      },
      {
        "ImageGarnitureId": "f9b21cb2-b438-43fa-a519-e887de9506ab",
        "StatusId": 30,
        "StatusName": "Đã duyệt đăng ký",
        "Note": "Cập nhật duyệt bộ ảnh",
        "CreatedDate": "2024-09-23 08:52:24.367",
        "CreatedByName": "Trang Trade Visibility"
      },
      {
        "ImageGarnitureId": "f9b21cb2-b438-43fa-a519-e887de9506ab",
        "StatusId": 100,
        "StatusName": "Từ chối đăng ký",
        "Note": "Lý do: Bộ hình chỉ có 1 tấm hình",
        "CreatedDate": "2024-09-23 08:51:08.257",
        "CreatedByName": "Trang Trade Visibility"
      },
      {
        "ImageGarnitureId": "f9b21cb2-b438-43fa-a519-e887de9506ab",
        "StatusId": 30,
        "StatusName": "Đã duyệt đăng ký",
        "Note": "Cập nhật duyệt bộ ảnh",
        "CreatedDate": "2024-09-23 08:51:03.240",
        "CreatedByName": "Trang Trade Visibility"
      },
      {
        "ImageGarnitureId": "f9b21cb2-b438-43fa-a519-e887de9506ab",
        "StatusId": 100,
        "StatusName": "Từ chối đăng ký",
        "Note": "Lý do: Bộ hình chỉ có 1 tấm hình",
        "CreatedDate": "2024-09-23 08:50:57.693",
        "CreatedByName": "Trang Trade Visibility"
      },
      {
        "ImageGarnitureId": "f9b21cb2-b438-43fa-a519-e887de9506ab",
        "StatusId": 30,
        "StatusName": "Đã duyệt đăng ký",
        "Note": "Cập nhật duyệt bộ ảnh",
        "CreatedDate": "2024-09-23 08:50:51.100",
        "CreatedByName": "Trang Trade Visibility"
      },
      {
        "ImageGarnitureId": "f9b21cb2-b438-43fa-a519-e887de9506ab",
        "StatusId": 100,
        "StatusName": "Từ chối đăng ký",
        "Note": "Lý do: Một kệ nhưng upload cho nhiều KH khác nhau",
        "CreatedDate": "2024-09-23 08:45:25.317",
        "CreatedByName": "Trang Trade Visibility"
      },
      {
        "ImageGarnitureId": "f9b21cb2-b438-43fa-a519-e887de9506ab",
        "StatusId": 30,
        "StatusName": "Đã duyệt đăng ký",
        "Note": "Cập nhật duyệt bộ ảnh",
        "CreatedDate": "2024-09-23 08:45:15.883",
        "CreatedByName": "Trang Trade Visibility"
      },
      {
        "ImageGarnitureId": "f9b21cb2-b438-43fa-a519-e887de9506ab",
        "StatusId": 100,
        "StatusName": "Từ chối đăng ký",
        "Note": "Lý do: Chụp không rõ các tầng kệ hoặc bộ hình không có tấm overview",
        "CreatedDate": "2024-09-23 08:44:32.067",
        "CreatedByName": "Vũ Thị Trang"
      },
      {
        "ImageGarnitureId": "f9b21cb2-b438-43fa-a519-e887de9506ab",
        "StatusId": 30,
        "StatusName": "Đã duyệt đăng ký",
        "Note": "Cập nhật duyệt bộ ảnh",
        "CreatedDate": "2024-09-23 08:44:27.240",
        "CreatedByName": "Vũ Thị Trang"
      },
      {
        "ImageGarnitureId": "f9b21cb2-b438-43fa-a519-e887de9506ab",
        "StatusId": 100,
        "StatusName": "Từ chối đăng ký",
        "Note": "Lý do: Bộ hình chỉ có 1 tấm hình",
        "CreatedDate": "2024-09-23 08:44:11.223",
        "CreatedByName": "Vũ Thị Trang"
      },
      {
        "ImageGarnitureId": "f9b21cb2-b438-43fa-a519-e887de9506ab",
        "StatusId": 30,
        "StatusName": "Đã duyệt đăng ký",
        "Note": "Cập nhật duyệt bộ ảnh",
        "CreatedDate": "2024-09-23 08:44:06.817",
        "CreatedByName": "Vũ Thị Trang"
      },
      {
        "ImageGarnitureId": "f9b21cb2-b438-43fa-a519-e887de9506ab",
        "StatusId": 100,
        "StatusName": "Từ chối đăng ký",
        "Note": "Lý do: Chụp không rõ các tầng kệ hoặc bộ hình không có tấm overview",
        "CreatedDate": "2024-09-23 08:44:03.960",
        "CreatedByName": "Vũ Thị Trang"
      },
      {
        "ImageGarnitureId": "f9b21cb2-b438-43fa-a519-e887de9506ab",
        "StatusId": 30,
        "StatusName": "Đã duyệt đăng ký",
        "Note": "Cập nhật duyệt bộ ảnh",
        "CreatedDate": "2024-09-23 08:40:42.943",
        "CreatedByName": "Trang Trade Visibility"
      },
      {
        "ImageGarnitureId": "f9b21cb2-b438-43fa-a519-e887de9506ab",
        "StatusId": 100,
        "StatusName": "Từ chối đăng ký",
        "Note": "Lý do: Chụp không rõ các tầng kệ hoặc bộ hình không có tấm overview",
        "CreatedDate": "2024-09-23 08:40:18.363",
        "CreatedByName": "Trang Trade Visibility"
      },
      {
        "ImageGarnitureId": "f9b21cb2-b438-43fa-a519-e887de9506ab",
        "StatusId": 30,
        "StatusName": "Đã duyệt đăng ký",
        "Note": "Cập nhật duyệt bộ ảnh",
        "CreatedDate": "2024-09-12 08:21:58.497",
        "CreatedByName": "Trang Trade Visibility"
      }
    ],
    "StatusName": "Thành công",
    "MessageTechnical": null,
    "ErrorMessage": "Thành công"
}
  ''';

  /// DMSSamplingOutletResultImageGarniture
  static final samplingOutletResultImageGarniture = '''
  {
    "StatusCode": 1,
    "Data": {
        "ComplianceStatusId": 2, // 1: Chờ kết quả chấm, 2: Đạt, 3: Không đạt
        "ComplianceStatus": "Đạt",
        "ComplianceSummary": "Đạt 2/2 điều kiện: 200% faces (54/27) và 100% groups (0/0)",
        "CreatedByName": "AI Chấm hình",
        "CreatedDate": "2024-09-12T08:21:58.497",
    },
    "StatusName": "Thành công",
    "MessageTechnical": null,
    "ErrorMessage": "Thành công"
}
  ''';

  /// DMSPromotionAIVComplaintReason
  static final getPromotionAIVComplaintReason = '''
  {
    "StatusCode": 1,
    "Data": [
        {
            "Id": 10,
            "Reason": "Khác",
            "CreatedAt": "0001-01-01T00:00:00+00:00",
            "CreatedByName": null,
            "CreatedBy": 0,
            "UpdatedAt": "0001-01-01T00:00:00+00:00",
            "UpdatedByName": null,
            "UpdatedBy": 0
        },
        {
            "Id": 9,
            "Reason": "Sản phẩm không đúng số lượng quy định",
            "CreatedAt": "0001-01-01T00:00:00+00:00",
            "CreatedByName": null,
            "CreatedBy": 0,
            "UpdatedAt": "0001-01-01T00:00:00+00:00",
            "UpdatedByName": null,
            "UpdatedBy": 0
        },
        {
            "Id": 8,
            "Reason": "Sản phẩm không đúng chủng loại quy định",
            "CreatedAt": "0001-01-01T00:00:00+00:00",
            "CreatedByName": null,
            "CreatedBy": 0,
            "UpdatedAt": "0001-01-01T00:00:00+00:00",
            "UpdatedByName": null,
            "UpdatedBy": 0
        },
        {
            "Id": 7,
            "Reason": "Sản phẩm thiếu so với quy định",
            "CreatedAt": "0001-01-01T00:00:00+00:00",
            "CreatedByName": null,
            "CreatedBy": 0,
            "UpdatedAt": "0001-01-01T00:00:00+00:00",
            "UpdatedByName": null,
            "UpdatedBy": 0
        },
        {
            "Id": 6,
            "Reason": "Sản phẩm không đúng vị trí quy định",
            "CreatedAt": "0001-01-01T00:00:00+00:00",
            "CreatedByName": null,
            "CreatedBy": 0,
            "UpdatedAt": "0001-01-01T00:00:00+00:00",
            "UpdatedByName": null,
            "UpdatedBy": 0
        }
    ],
    "StatusName": "Thành công",
    "MessageTechnical": null,
    "ErrorMessage": "Thành công"
}
  ''';

  /// DMSPromotionAIVComplaint
  static final promotionAIVComplaint = '''
  {
    "StatusCode": 1,
    "Data": {
        "ID": 1,
        "Message": "Thêm mới record thành công.",
        "SystemMessage": "Db_ExecuteStoreSucceed"
    },
    "StatusName": "Thành công",
    "MessageTechnical": null,
    "ErrorMessage": "Thành công"
}
  ''';
}
