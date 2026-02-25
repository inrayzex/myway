<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table) {

        $table->string('username')->unique()->nullable();

        $table->string('status')->nullable()->default('seeker');

        $table->text('quote')->nullable();

        $table->string('trackers_privacy')->default('друзья')->after('quote');
        $table->string('posts_privacy')->default('все')->after('trackers_privacy');
        $table->string('avatar_url')->nullable()->after('posts_privacy');

    });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {

        $table->dropColumn(['username', 'status', 'quote']);

        $table->dropColumn(['trackers_privacy', 'posts_privacy', 'avatar_url']);

    });
    }
};
