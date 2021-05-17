import 'package:flutter/foundation.dart';
import 'package:supabase/supabase.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weak_plan/service/config.dart';
import 'package:uni_links/uni_links.dart';

class AuthService extends ChangeNotifier {
  late SupabaseClient _client;

  bool get isLoggedIn => _client.auth.currentUser != null;

  AuthService() {
    // Configure your supabase client
    _client = SupabaseClient(Config.supabaseUrl, Config.supabaseKey);

    // Call notifyListeners on auth state change so your UI can update
    _client.auth.onAuthStateChange((event, session) async {
      notifyListeners();
    });

    // uni_links will trigger this after the user logs in
    linkStream.listen(_handleAuthCallback);
  }

  Future<void> login(Provider provider) async {
    var result = await _client.auth.signIn(
      provider: provider,
      options: ProviderOptions(redirectTo: 'weakplan://com.jrai.weakplan'),
    );
    var url = result.url;
    if (url != null) {
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false);
      }
    }
  }

  Future<void> _handleAuthCallback(String? link) async {
    if (link == null) return;

    link = link.replaceFirst('#', '?');
    var uri = Uri.parse(link);
    await _client.auth.getSessionFromUrl(uri);
  }
}
