//
//  ResponseApi.swift
//  VideogamesArchive
//
//  Created by Rigoberto Sáenz Imbacuán on 1/1/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import Moya

enum ResponseApi {
    case success(result: Response)
    case failure(error: String)
    case offline(error: String)
    case timeOut(error: String)
}
