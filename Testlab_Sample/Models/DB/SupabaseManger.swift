//
//  SupabaseManger.swift
//  Testlab_Sample
//
//  Created by Chase Moffat on 3/5/25.
//

import Foundation
import Supabase

struct SupabaseManager {
    static let shared = SupabaseManager()

    let supabase = SupabaseClient(
        supabaseURL: URL(string: ProcessInfo.processInfo.environment["SUPABASE_URL"] ?? "https://your-project.supabase.co")!,
        supabaseKey: ProcessInfo.processInfo.environment["SUPABASE_KEY"] ?? "your-anon-key"
    )
}
