<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{

public function up(): void
{
    Schema::create('club_post_likes', function (Blueprint $table) {
        $table->uuid('id')->primary();
        $table->foreignUuid('user_id')->constrained()->onDelete('cascade');
        $table->foreignUuid('club_post_id')->constrained('club_posts')->onDelete('cascade');
        $table->timestamps();
        
        $table->unique(['user_id', 'club_post_id']);
    });
}

public function down(): void
{
    Schema::dropIfExists('club_post_likes');
}


};
