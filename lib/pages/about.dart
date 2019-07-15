import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';

disclaimer() {
  return Container(
      margin: EdgeInsets.symmetric(
          vertical: ScreenUtil.getInstance().setHeight(30),
          horizontal: ScreenUtil.getInstance().setWidth(30)),
      child: ListView(children: <Widget>[
        Text(
          'Disclaimer',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(50)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'This disclaimer ("Disclaimer", "Agreement") is an agreement between Mobile Application Developer ("Mobile Application Developer", "us", "we" or "our") and you ("User", "you" or "your"). This Disclaimer sets forth the general guidelines, terms and conditions of your use of the SOSNYP mobile application and any of its products or services (collectively, "Mobile Application" or "Services").',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(30)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'Misconduct',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(40)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'This application is only to be used in emergencies and serious situations should they arise. Any users caught misusing the application will be reported to their PEMs and respective school CC.',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(30)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'Representation',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(40)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'Any views or opinions represented in this Mobile Application are personal and belong solely to Mobile Application Developer and do not represent those of people, institutions or organizations that the owner may or may not be associated with in professional or personal capacity unless explicitly stated. Any views or opinions are not intended to malign any religion, ethnic group, club, organization, company, or individual.',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(30)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'Content and postings',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(40)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'You may not modify, print or copy any part of the Mobile Application. Inclusion of any part of this Mobile Application in another work, whether in printed or electronic or another form or inclusion of any part of the Mobile Application in another mobile application by embedding, framing or otherwise without the express permission of Mobile Application Developer is prohibited.',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(30)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'Indemnification and warranties',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(40)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'While we have made every attempt to ensure that the information contained in the Mobile Application is correct, Mobile Application Developer is not responsible for any errors or omissions, or for the results obtained from the use of this information. All information in the Mobile Application is provided "as is", with no guarantee of completeness, accuracy, timeliness or of the results obtained from the use of this information, and without warranty of any kind, express or implied. In no event will Mobile Application Developer be liable to you or anyone else for any decision made or action taken in reliance on the information in the Mobile Application or for any consequential, special or similar damages, even if advised of the possibility of such damages. Information in the Mobile Application is for general information purposes only and is not intended to provide legal, financial, medical, or any other type of professional advice. Please seek professional assistance should you require it. Furthermore, information contained in the Mobile Application and any pages linked to and from it are subject to change at any time and without warning.',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(30)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'We reserve the right to modify this Disclaimer relating to the Mobile Application or Services at any time, effective upon posting of an updated version of this Disclaimer in the Mobile Application. When we do we will revise the updated date at the bottom of this page. Continued use of the Mobile Application after any such changes shall constitute your consent to such changes. Policy was created with WebsitePolicies.',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(30)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'Acceptance of this disclaimer',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(40)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'You acknowledge that you have read this Disclaimer and agree to all its terms and conditions. By accessing the Mobile Application you agree to be bound by this Disclaimer. If you do not agree to abide by the terms of this Disclaimer, you are not authorized to use or access the Mobile Application.',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(30)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'Contacting us',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(40)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'If you have any questions about this Disclaimer, please contact us.',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(30)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'This document was last updated on July 8, 2019',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(20)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
      ]));
}

termsAndCondition() {
  return Container(
      margin: EdgeInsets.symmetric(
          vertical: ScreenUtil.getInstance().setHeight(30),
          horizontal: ScreenUtil.getInstance().setWidth(30)),
      child: ListView(children: <Widget>[
        Text(
          'Terms & Conditions',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(50)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'These terms and conditions ("Terms", "Agreement") are an agreement between Mobile Application Developer ("Mobile Application Developer", "us", "we" or "our") and you ("User", "you" or "your"). This Agreement sets forth the general terms and conditions of your use of the SOSNYP mobile application and any of its products or services (collectively, "Mobile Application" or "Services").',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(30)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'Accounts and membership',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(40)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'If you create an account in the Mobile Application, you are responsible for maintaining the security of your account and you are fully responsible for all activities that occur under the account and any other actions taken in connection with it. We may, but have no obligation to, monitor and review new accounts before you may sign in and use our Services. Providing false contact information of any kind may result in the termination of your account. You must immediately notify us of any unauthorized uses of your account or any other breaches of security. We will not be liable for any acts or omissions by you, including any damages of any kind incurred as a result of such acts or omissions. We may suspend, disable, or delete your account (or any part thereof) if we determine that you have violated any provision of this Agreement or that your conduct or content would tend to damage our reputation and goodwill. If we delete your account for the foregoing reasons, you may not re-register for our Services. We may block your email address and Internet protocol address to prevent further registration.',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(30)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'User content',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(40)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'We do not own any data, information or material ("Content") that you submit in the Mobile Application in the course of using the Service. You shall have sole responsibility for the accuracy, quality, integrity, legality, reliability, appropriateness, and intellectual property ownership or right to use of all submitted Content. We may monitor and review Content in the Mobile Application submitted or created using our Services by you. Unless specifically permitted by you, your use of the Mobile Application does not grant us the license to use, reproduce, adapt, modify, publish or distribute the Content created by you or stored in your user account for commercial, marketing or any similar purpose. But you grant us permission to access, copy, distribute, store, transmit, reformat, display and perform the Content of your user account solely as required for the purpose of providing the Services to you. Without limiting any of those representations or warranties, we have the right, though not the obligation, to, in our own sole discretion, refuse or remove any Content that, in our reasonable opinion, violates any of our policies or is in any way harmful or objectionable.',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(30)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'Backups',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(40)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'We are not responsible for Content residing in the Mobile Application. In no event shall we be held liable for any loss of any Content. It is your sole responsibility to maintain appropriate backup of your Content. Notwithstanding the foregoing, on some occasions and in certain circumstances, with absolutely no obligation, we may be able to restore some or all of your data that has been deleted as of a certain date and time when we may have backed up data for our own purposes. We make no guarantee that the data you need will be available.',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(30)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'Links to other mobile applications',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(40)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'Although this Mobile Application may link to other mobile applications, we are not, directly or indirectly, implying any approval, association, sponsorship, endorsement, or affiliation with any linked mobile application, unless specifically stated herein. We are not responsible for examining or evaluating, and we do not warrant the offerings of, any businesses or individuals or the content of their mobile applications. We do not assume any responsibility or liability for the actions, products, services, and content of any other third-parties. You should carefully review the legal statements and other conditions of use of any mobile application which you access through a link from this Mobile Application. Your linking to any other off-site mobile applications is at your own risk.',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(30)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'Prohibited uses',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(40)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'In addition to other terms as set forth in the Agreement, you are prohibited from using the Mobile Application or its Content: (a) for any unlawful purpose; (b) to solicit others to perform or participate in any unlawful acts; (c) to violate any international, federal, provincial or state regulations, rules, laws, or local ordinances; (d) to infringe upon or violate our intellectual property rights or the intellectual property rights of others; (e) to harass, abuse, insult, harm, defame, slander, disparage, intimidate, or discriminate based on gender, sexual orientation, religion, ethnicity, race, age, national origin, or disability; (f) to submit false or misleading information; (g) to upload or transmit viruses or any other type of malicious code that will or may be used in any way that will affect the functionality or operation of the Service or of any related mobile application, other mobile applications, or the Internet; (h) to collect or track the personal information of others; (i) to spam, phish, pharm, pretext, spider, crawl, or scrape; (j) for any obscene or immoral purpose; or (k) to interfere with or circumvent the security features of the Service or any related mobile application, other mobile applications, or the Internet. We reserve the right to terminate your use of the Service or any related mobile application for violating any of the prohibited uses.',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(30)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'Intellectual property rights',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(40)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'This Agreement does not transfer to you any intellectual property owned by Mobile Application Developer or third-parties, and all rights, titles, and interests in and to such property will remain (as between the parties) solely with Mobile Application Developer. All trademarks, service marks, graphics and logos used in connection with our Mobile Application or Services, are trademarks or registered trademarks of Mobile Application Developer or Mobile Application Developer licensors. Other trademarks, service marks, graphics and logos used in connection with our Mobile Application or Services may be the trademarks of other third-parties. Your use of our Mobile Application and Services grants you no right or license to reproduce or otherwise use any Mobile Application Developer or third-party trademarks.',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(30)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'Limitation of liability',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(40)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'To the fullest extent permitted by applicable law, in no event will Mobile Application Developer, its affiliates, officers, directors, employees, agents, suppliers or licensors be liable to any person for (a): any indirect, incidental, special, punitive, cover or consequential damages (including, without limitation, damages for lost profits, revenue, sales, goodwill, use or content, impact on business, business interruption, loss of anticipated savings, loss of business opportunity) however caused, under any theory of liability, including, without limitation, contract, tort, warranty, breach of statutory duty, negligence or otherwise, even if Mobile Application Developer has been advised as to the possibility of such damages or could have foreseen such damages. To the maximum extent permitted by applicable law, the aggregate liability of Mobile Application Developer and its affiliates, officers, employees, agents, suppliers and licensors, relating to the services will be limited to an amount greater of one dollar or any amounts actually paid in cash by you to Mobile Application Developer for the prior one month period prior to the first event or occurrence giving rise to such liability. The limitations and exclusions also apply if this remedy does not fully compensate you for any losses or fails of its essential purpose.',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(30)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'Indemnification',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(40)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'You agree to indemnify and hold Mobile Application Developer and its affiliates, directors, officers, employees, and agents harmless from and against any liabilities, losses, damages or costs, including reasonable attorneys\' fees, incurred in connection with or arising from any third-party allegations, claims, actions, disputes, or demands asserted against any of them as a result of or relating to your Content, your use of the Mobile Application or Services or any willful misconduct on your part.',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(30)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'Severability',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(40)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'All rights and restrictions contained in this Agreement may be exercised and shall be applicable and binding only to the extent that they do not violate any applicable laws and are intended to be limited to the extent necessary so that they will not render this Agreement illegal, invalid or unenforceable. If any provision or portion of any provision of this Agreement shall be held to be illegal, invalid or unenforceable by a court of competent jurisdiction, it is the intention of the parties that the remaining provisions or portions thereof shall constitute their agreement with respect to the subject matter hereof, and all such remaining provisions or portions thereof shall remain in full force and effect.',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(30)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'Dispute resolution',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(40)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'The formation, interpretation, and performance of this Agreement and any disputes arising out of it shall be governed by the substantive and procedural laws of General, Singapore without regard to its rules on conflicts or choice of law and, to the extent applicable, the laws of Singapore. The exclusive jurisdiction and venue for actions related to the subject matter hereof shall be the state and federal courts located in General, Singapore, and you hereby submit to the personal jurisdiction of such courts. You hereby waive any right to a jury trial in any proceeding arising out of or related to this Agreement. The United Nations Convention on Contracts for the International Sale of Goods does not apply to this Agreement.',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(30)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'Changes and amendments',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(40)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'We reserve the right to modify this Agreement or its policies relating to the Mobile Application or Services at any time, effective upon posting of an updated version of this Agreement in the Mobile Application. When we do, we will revise the updated date at the bottom of this page. Continued use of the Mobile Application after any such changes shall constitute your consent to such changes. Policy was created with WebsitePolicies.',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(30)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'Acceptance of these terms',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(40)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'You acknowledge that you have read this Agreement and agree to all its terms and conditions. By using the Mobile Application or its Services you agree to be bound by this Agreement. If you do not agree to abide by the terms of this Agreement, you are not authorized to use or access the Mobile Application and its Services.',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(30)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'Contacting us',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(40)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'If you have any questions about this Agreement, please contact us.',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(30)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
        Text(
          'This document was last updated on July 8, 2019',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(20)),
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
      ]));
}

class AboutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return CollapsingList();
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class CollapsingList extends StatelessWidget {
  SliverPersistentHeader makeHeader(String headerText) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 60.0,
        maxHeight: 60.0,
        child: Container(
            color: Colors.grey,
            child: Center(
                child: Text(
              headerText,
            ))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        makeHeader('Terms and Conditions'),
        SliverFixedExtentList(
          itemExtent: ScreenUtil.getInstance().setHeight(550),
          delegate: SliverChildListDelegate(
            [
              Column(children: <Widget>[
                Spacer(),
                AutoSizeText(
                  'Terms & Conditions',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style:
                      TextStyle(fontSize: ScreenUtil.getInstance().setSp(50)),
                ),
                Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil.getInstance().setWidth(12)),
                    height: ScreenUtil.getInstance().setHeight(300),
                    child: Center(
                        child: AutoSizeText(
                      'These terms and conditions ("Terms", "Agreement") are an agreement between Mobile Application Developer ("Mobile Application Developer", "us", "we" or "our") and you ("User", "you" or "your"). This Agreement sets forth the general terms and conditions of your use of the SOSNYP mobile application and any of its products or services (collectively, "Mobile Application" or "Services").',
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(30)),
                    ))),
                Spacer(),
              ]),
            ],
          ),
        ),
        makeHeader('Disclaimer'),
        SliverFixedExtentList(
          itemExtent: ScreenUtil.getInstance().setHeight(350),
          delegate: SliverChildListDelegate([
            Text('data'),
          ]),
        ),
      ],
    );
  }
}
